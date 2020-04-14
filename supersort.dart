import 'dart:math';

int totalArraysCreated = 0;
int totalSortCalls = 0;
int comparisons = 0;
int calls = 0;

void main() {
  List<int> unsortedList = generateRandomList(total: 1000, max: 1000);
  try {
    List<List<int>> sortedPiles = pileSort(unsortedList);

    print("Unsorted");
    print(unsortedList);
    print("Soted Piles");
    print(sortedPiles);
    print("Total arrays: $totalArraysCreated");
    print("Total Sort Calls: $totalSortCalls");
//    print("Total Comparisons: $comparisons");
    print("Total Calls: $calls");
  } catch (e) {
    print(e);
  }
}

T call<T>(Function function) {
  calls++;
  return function();
}

List<List<int>> pileSort(List<int> unsortedList) {
  totalSortCalls++;

  // if all the values are the same then return the list as it is
  if (unsortedList.every((value) => value == unsortedList[0])) {
    return [unsortedList];
  }

  int min = unsortedList[0];
  int max = unsortedList[0];

  unsortedList.forEach((value) {
    if (call(() => value < min)) {
      min = value;
      return;
    }

    if (call(() => value > min)) {
      max = value;
      return;
    }
  });

  int minPlusMax = call(() => min + max);
  int range = max - min;
  int totalPiles = range;

  Map<int, List<int>> piles = Map();

  unsortedList.forEach((value) {
    int index = ((value / minPlusMax) * totalPiles).toInt();
    if (index == piles.length) {
      index--;
    }
    if (!piles.containsKey(index)) {
      totalArraysCreated++;
      piles[index] = [];
    }
    piles[index].add(value);
  });

  List<List<int>> sortedPiles = List();

  for (int i = 0; i < piles.length; i++) {
    if(piles.containsKey(i)){
      sortedPiles.add(piles[i]);
    }
  }

  return sortedPiles;

//  piles.fold<List<List<int>>>([], (previous, element) {
//    if (element.isNotEmpty) {
//      previous.addAll(pileSort(element));
//    }
//    return previous;
//  });
//  return sortedPiles;
}

List<int> generateRandomList({int total = 100, int max = 1000}) {
  Random random = Random();
  List<int> unsortedList = List();
  for (int i = 0; i < total; i++) {
    unsortedList.add(random.nextInt(max));
  }
  return unsortedList;
}
