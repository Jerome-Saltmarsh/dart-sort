//
//List<List<int>> pileIntSort(List<int> unsortedList) {
//
//  int length = unsortedList.length;
//  int min = unsortedList[0];
//  int max = unsortedList[0];
//
//  for (int i = 0; i < length; i++) {
//    if (unsortedList[i] < min) {
//      min = unsortedList[i];
//    } else if (unsortedList[i] > max) {
//      max = unsortedList[i];
//    }
//  }
//
//  if (max == min) {
//    return [unsortedList];
//  }
//
//  int range = max - min;
//  Map<int, List<int>> piles = Map();
//  int maxIndex = length - 1;
//
//  for (int i = 0; i < length; i++) {
//
//    int index = (((unsortedList[i] - min) / range) * maxIndex).toInt();
//
//    if (piles.containsKey(index)) {
//      piles[index].add(unsortedList[i]);
//    } else {
//      piles[index] = [unsortedList[i]];
//    }
//  }
//
//  List<List<int>> sortedPiles = List();
//
//  for (int i = 0; i < maxIndex; i++) {
//    if (piles.containsKey(i)) {
//      sortedPiles.add(piles[i]);
//    }
//  }
//
//  return sortedPiles;
//}

import 'main.dart';
import 'utility.dart';

// The problem with pile sort is that it becomes increasingly slow as the range increases
// Solution limit the index count to 100
// Store pass the min and max values to the recursion
dynamic pileIntSort(List<int> unsortedList) {
  print("PileSortInt Starting");
  DateTime startTime = DateTime.now();

  int min = unsortedList[0];
  int max = unsortedList[0];

  for (int i = 1; i < unsortedList.length; i++) {
    if (unsortedList[i] < min) {
      min = unsortedList[i];
    } else if (unsortedList[i] > max) {
      max = unsortedList[i];
    }
  }

  int range = max - min;
  int maxIndex = range;
  List<List<int>> piles = List(range + 1);

  for (int i = 0; i <= maxIndex; i++) {
    piles[i] = [];
  }

  for (int i = 0; i < unsortedList.length; i++) {
    int index = (((unsortedList[i] - min) / range) * maxIndex).toInt();
    int value = unsortedList[i];
    piles[index].add(value);
  }
  var results = piles.fold([], (previous, pile) {
    if (pile != null) {
      previous.addAll(pile);
    }
    return previous;
  });

  DateTime endTime = DateTime.now();
  Duration duration = endTime.difference(startTime);
  print(
      "PileSort finished sorting ${unsortedList.length} in ${toText(duration)}");
  return results;
}

dynamic pileIntSortRecursive(List<int> unsortedList, {int defaultIndexCount = 100, double min, double max}) {

  bool isSubSort = min != null;
  DateTime startTime;

  if (min == null) {

    print("pileIntSortRecursive Starting");
    startTime = DateTime.now();

    int minInt = unsortedList[0];
    int maxInt = unsortedList[0];

    for (int i = 1; i < unsortedList.length; i++) {
      if (unsortedList[i] < minInt) {
        minInt = unsortedList[i];
      } else if (unsortedList[i] > maxInt) {
        maxInt = unsortedList[i];
      }
    }

    if (minInt == maxInt) {
      return unsortedList;
    }

    min = minInt.toDouble();
    max = maxInt.toDouble();
  } else {
    if (min == max) {
      return [unsortedList];
    }
  }

  if(unsortedList.length < 2){
    throw Exception("Incorrect");
  }

//  if(unsortedList.length == 2){
//      if(unsortedList[0] < unsortedList[1]){
//        return [unsortedList[0], unsortedList[1]];
//      }else{
//        return [unsortedList[1], unsortedList[0]];
//      }
//  }

  double range = max - min;
  int totalIndexes = unsortedList.length > defaultIndexCount ? defaultIndexCount : unsortedList.length;
  List<List<int>> piles = List(totalIndexes + 1);

  for (int i = 0; i < unsortedList.length; i++) {
    int value = unsortedList[i];
    int index = (((value - min) / range) * totalIndexes).toInt();

    if (piles[index] == null) {
      piles[index] = [value];
    } else {
      piles[index].add(value);
    }
  }

  double indexSize = range / totalIndexes;

  for (int i = 0; i < totalIndexes; i++) {
    double newMin = min + (i * indexSize);
    double newMax = newMin + indexSize;

    if (piles[i] != null) {

//      insertionSort(piles[i]);
//        var subPile = pileIntSortRecursive(piles[i],
//            min: newMin, max: newMax);
//
//        List<int> list = [];
//        var unfolded = subPile.fold(list, (previous, pile) {
//          if (pile != null) {
//            previous.addAll(pile);
//          }
//          return previous;
//        });
//
//        piles[i] = unfolded;
        piles[i].sort(quickSortInt);

    }
  }

//  if (isSubSort) {
//    return piles;
//  }

//  return piles;
//  var results = piles.fold([], (previous, pile) {
//    if (pile != null) {
//      previous.addAll(pile);
//    }
//    return previous;
//  });

  DateTime endTime = DateTime.now();
  Duration duration = endTime.difference(startTime);
  print(
      "PileSort finished sorting ${unsortedList.length} in ${toText(duration)}");
  return piles;
}
