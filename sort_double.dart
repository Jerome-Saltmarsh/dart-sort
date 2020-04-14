List pileSortDouble(List<double> unsortedList) {

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
  Map<int, dynamic> piles = Map();
  int maxIndex = (unsortedList.length - 1);

  unsortedList.forEach((value) {
    double indexDouble = (value - min) / range * maxIndex;
    int index = indexDouble.toInt();

    if (!piles.containsKey(index)) {
      piles[index] = value;
    } else if (piles[index] is double) {
      List<double> list = [piles[index], value];
      piles[index] = list;
    } else {
      piles[index].add(value);
    }
  });

  List sortedPiles = List();

//  for (int i = 0; i <= maxIndex; i++) {
//    if (piles.containsKey(i)) {
//      if (piles[i] is double) {
//        sortedPiles.add(piles[i]);
//      } else {
//        List<double> unsortedPile = piles[i];
//        List subPiles = pileSortDouble(unsortedPile);
//        List<double> sortedSubList = pilesToList(subPiles);
//        sortedPiles.add(sortedSubList);
//      }
//    }
//  }
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
