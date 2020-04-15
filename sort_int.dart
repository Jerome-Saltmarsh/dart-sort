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



import 'utility.dart';

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

  for(int i = 0; i <= maxIndex; i++){
    piles[i] = [];
  }

  for (int i = 0; i < unsortedList.length; i++) {
    int index = (((unsortedList[i] - min) / range) * maxIndex).toInt();
    piles[index].add(unsortedList[i]);
  }
  var results = piles.fold([], (previous, pile){
    if(pile != null){
      previous.addAll(pile);
    }
    return previous;
  });

  DateTime endTime = DateTime.now();
  Duration duration = endTime.difference(startTime);
  print("PileSort finished sorting ${unsortedList.length} in ${toText(duration)}");
  return results;

//  return piles.where((pile) => pile != null).toList();
}


dynamic pileIntSortCache(List<int> unsortedList) {

  print("PileSortInt Cache Starting");
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
  int maxIndex = range - 1;
//  int length = unsortedList.length;

  List<List<int>> piles = List(range);

//  List<int> valueIndexCache = List(maxIndex);
  Map<int, int> valueIndexCache = Map();

  for(int value = min; value <= max; value++){
    valueIndexCache[value] = (((value - min) / range) * maxIndex).toInt();
  }



  for (int i = 0; i < unsortedList.length; i++) {
//    int index = (((unsortedList[i] - min) / range) * maxIndex).toInt();
    int index = valueIndexCache[unsortedList[i]];

    if (piles[index] == null) {
      piles[index] = [unsortedList[i]];
    } else {
      piles[index].add(unsortedList[i]);
    }
  }

  var results = piles.fold([], (previous, pile){
    if(pile != null){
      previous.addAll(pile);
    }
    return previous;
  });

  DateTime endTime = DateTime.now();
  Duration duration = endTime.difference(startTime);
  print("PileSort finished sorting ${unsortedList.length} in ${toText(duration)}");
  return results;

//  return piles.where((pile) => pile != null).toList();
}

