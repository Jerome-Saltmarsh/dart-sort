import 'dart:async';
import 'dart:math';

int totalArraysCreated = 0;
int comparisons = 0;
int calls = 0;

void main() {
  const int total = 10000000;
  print("Generating Random List");
  List<double> unsortedList = generateRandomDoubles(total: total, max: 1);
//  print(unsortedList);
  try {
    print("Starting Sort");
    List<List<double>> sortedPiles = pileSortDouble(unsortedList);
    print("Sort Finished");

    List<double> sortedNumbers =
        sortedPiles.fold<List<double>>([], (all, pile) {
      all.addAll(pile);
      return all;
    });

//    if (sortedNumbers.length != unsortedList.length) {
//      throw Exception(
//          "Numbers missing. Found ${sortedNumbers.length}, expected ${unsortedList.length}");
//    }
//
//    for (int i = 0; i < sortedNumbers.length - 1; i++) {
//      if (sortedNumbers[i] > sortedNumbers[i + 1]) {
//        throw Exception("Out of order index: $i, ${sortedNumbers[i]} ${sortedNumbers[i + 1]}");
//      }
//    }

//    print("Sorted Piles");
//    print(sortedPiles);
//    print(sortedNumbers);
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

List<double> pilesToList(List<List<double>> piles) {
  return piles.fold<List<double>>([], (all, pile) {
    all.addAll(pile);
    return all;
  });
}

List<List<int>> pileSort(List<int> unsortedList) {
  // if all the values are the same then return the list as it is
//  if (unsortedList.every((value) => value == unsortedList[0])) {
//    return [unsortedList];
//  }

  if (unsortedList.length < 2) {
    return [unsortedList];
  }

  int min = unsortedList[0];
  int max = unsortedList[0];

  for (int i = 0; i < unsortedList.length; i++) {
    if (unsortedList[i] < min) {
      min = unsortedList[i];
    } else if (unsortedList[i] > max) {
      max = unsortedList[i];
    }
  }

  if (max == min) {
    return [unsortedList];
  }

  int range = max - min;
  Map<int, List<int>> piles = Map();

  unsortedList.forEach((value) {
    double indexDouble = ((value - min) / range) * 100;
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

List<List<double>> pileSortDouble(List<double> unsortedList) {

  calls++;
  if (unsortedList.length < 2) {
    return [unsortedList];
  }

  double min = unsortedList[0];
  double max = unsortedList[0];

  for (int i = 0; i < unsortedList.length; i++) {
    if (unsortedList[i] < min) {
      min = unsortedList[i];
    } else if (unsortedList[i] > max) {
      max = unsortedList[i];
    }
  }

  if (max == min) {
    return [unsortedList];
  }

  double range = max - min;
  Map<int, List<double>> piles = Map();

  unsortedList.forEach((value) {
    double indexDouble = ((value - min) / range) * 100;
    int index = indexDouble.toInt();
    if (!piles.containsKey(index)) {
      totalArraysCreated++;
      piles[index] = [];
    }
    piles[index].add(value);
  });

  List<List<double>> sortedPiles = List();

  for (int i = 0; i <= 100; i++) {
    if (piles.containsKey(i)) {
      List<double> pile = piles[i];
      if (pile.length > 1) {
        List<List<double>> subPiles = pileSortDouble(pile);
        List<double> subList = pilesToList(subPiles);
        sortedPiles.add(subList);
      } else {
        sortedPiles.add(pile);
      }
    }
  }

  return sortedPiles;
}

List<int> generateRandomList(
    {int total = 100, int max = 1000, bool includeNegatives = true}) {
  Random random = Random(DateTime.now().microsecond);
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

List<double> generateRandomDoubles(
    {int total = 100, int max = 1000, bool includeNegatives = true}) {

  Random random = Random(DateTime.now().microsecond);
  List<double> unsortedList = List();
  for (int i = 0; i < total; i++) {
    double value = random.nextDouble() * max;
    if (includeNegatives) {
      if (random.nextBool()) {
        value = -value;
      }
    }

    unsortedList.add(value);
  }
  return unsortedList;
}
