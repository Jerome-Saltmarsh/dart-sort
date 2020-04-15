List pileSortDouble(List<double> unsortedList, {double min, double max}) {

  if (min == null) {
    min = unsortedList[0];
    max = unsortedList[0];

    for (int i = 0; i < unsortedList.length; i++) {
      if (unsortedList[i] < min) {
        min = unsortedList[i];
      } else if (unsortedList[i] > max) {
        max = unsortedList[i];
      }
    }
  }

  if (max == min) {
    return [unsortedList];
  }

  double range = max - min;
  Map<int, dynamic> piles = Map();
//  int maxIndex = (unsortedList.length - 1);
  int maxIndex = 40000;
  double indexRange = range / maxIndex;

  for (double value in unsortedList) {
    double indexDouble = (value - min) / range * maxIndex;
    int index = indexDouble.toInt();

    if (piles.containsKey(index)) {
      piles[index].add(value);
    } else {
      piles[index] = [value];
    }
  }

  List sortedPiles = List();

  for (int i = 0; i <= maxIndex; i++) {
    if (piles.containsKey(i)) {
      if (piles[i].length > 1) {
//        sortedPiles.addAll(pilesToList(pileSortDouble(piles[i])));

        // Save left and right boundaries
//        double mins = min + (indexRange * i);
//        double maxs = mins + indexRange;
//        List sortedSubList = pileSortDouble(piles[i]);
//        sortedPiles.addAll(sortedSubList);
        sortedPiles.addAll(piles[i]);
//        sortedPiles.add(testQuickSortDouble(piles[i]));
      } else {
        sortedPiles.add(piles[i]);
      }
//      if (piles[i] is double) {
//        sortedPiles.add(piles[i]);
//      } else {
//        List<double> unsortedPile = piles[i];
//        List subPiles = pileSortDouble(unsortedPile);
//        List<double> sortedSubList = pilesToList(subPiles);
//        sortedPiles.add(sortedSubList);
//      }
//        if(piles[i].length > 1){
//
//        }else{
//
//        }

    }
  }
  return sortedPiles;
}

List<double> pilesToList(List piles) {
  return piles.fold<List<double>>([], (all, pile) {
    if (pile is double) {
      all.add(pile);
    } else {
      all.addAll(pile);
    }
    return all;
  });
}
