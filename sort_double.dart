

List pileSortDouble(List<double> unsortedList) {
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
//  Map<int, List<double>> piles = Map();

  Map<int, dynamic> pilesZ = Map();

  int maxIndex = (unsortedList.length - 1);

  unsortedList.forEach((value) {
    double indexDouble = ((value - min) / range) * maxIndex;
    int index = indexDouble.toInt();

    if (!pilesZ.containsKey(index)) {
      pilesZ[index] = value;
    } else if (pilesZ[index] is double) {
      List<double> list = [pilesZ[index], value];
      pilesZ[index] = list;
    } else {
      pilesZ[index].add(value);
    }

//    if (!piles.containsKey(index)) {
//      totalArraysCreated++;
//      piles[index] = [];
//    }
//    piles[index].add(value);
  });

  List sortedPiles = List();

//  for (int i = 0; i < maxIndex; i++) {
//    if (piles.containsKey(i)) {
//      List<double> pile = piles[i];
//      if (pile.length > 1) {
//        List<List<double>> subPiles = pileSortDouble(pile);
//        List<double> subList = pilesToList(subPiles);
//        sortedPiles.add(subList);
//      } else {
//        sortedPiles.add(pile);
//      }
//    }
//  }

  for (int i = 0; i <= maxIndex; i++) {
    if (pilesZ.containsKey(i)) {
      if (pilesZ[i] is double) {
        sortedPiles.add(pilesZ[i]);
      } else {
        List<double> unsortedPile = pilesZ[i];
        List subPiles = pileSortDouble(unsortedPile);
        List<double> sortedSubList = pilesToList(subPiles);
        sortedPiles.add(sortedSubList);
      }
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