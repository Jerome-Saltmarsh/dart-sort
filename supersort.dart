import 'dart:math';

int totalArraysCreated = 0;
int comparisons = 0;
int calls = 0;

void main() {
  const int total = 10000;
  print("Generating Random List");
  List<int> unsortedList = generateRandomList(total: total, max: 100);
  try {
    print("Starting Sort");
    List<List<int>> sortedPiles = pileSort(unsortedList);
    print("Sort Finished");

//    print("Unsorted");
//    print(unsortedList);
    print("Sorted Piles");
    print(sortedPiles);
    print("Total Elements: $total");
    print("Total Arrays: $totalArraysCreated");
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
  // if all the values are the same then return the list as it is
//  if (unsortedList.every((value) => value == unsortedList[0])) {
//    return [unsortedList];
//  }

  if (unsortedList.isEmpty) {
    return [];
  }

  int min = unsortedList[0];
  int max = unsortedList[0];

  int unsortedListLength = unsortedList.length;

  for (int i = 0; i < unsortedListLength; i++) {
    if (unsortedList[i] < min) {
      min = unsortedList[i];
    } else if (unsortedList[i] > min) {
      max = unsortedList[i];
    }
  }

//  unsortedList.forEach((value) {
//    if (call(() => value < min)) {
//      min = value;
//      return;
//    }
//
//    if (call(() => value > max)) {
//      max = value;
//      return;
//    }
//  });

  if (max == min) {
    return [unsortedList];
  }

//  int range = max - min;
  double indexRatio = (max - min) / 100;
  Map<int, List<int>> piles = Map();

  unsortedList.forEach((value) {
    double indexDouble = (value - min) * indexRatio;
    int index = indexDouble.toInt();
    if (!piles.containsKey(index)) {
      totalArraysCreated++;
      piles[index] = [];
    }
    piles[index].add(value);
  });

  List<List<int>> sortedPiles = List();

  for (int i = 0; i < piles.length; i++) {
    if (piles.containsKey(i)) {
      sortedPiles.add(piles[i]);
    }
  }

  return sortedPiles;
}

List<int> generateRandomList(
    {int total = 100, int max = 1000, bool includeNegatives = true}) {
  Random random = Random();
  List<int> unsortedList = List();
  for (int i = 0; i < total; i++) {
    int value = random.nextInt(max);
    if (includeNegatives) {
      if (random.nextBool()) {
        value = -value;
      }
    }

    unsortedList.add(value);
  }
  return unsortedList;
}
