List<List<int>> pileIntSort(List<int> unsortedList) {

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

  int maxIndex = (unsortedList.length - 1);

  unsortedList.forEach((value) {
    double indexDouble = ((value - min) / range) * maxIndex;
    int index = indexDouble.toInt();
    if (!piles.containsKey(index)) {
      piles[index] = [];
    }
    piles[index].add(value);
  });

  List<List<int>> sortedPiles = List();

  for (int i = 0; i < maxIndex; i++) {
    if (piles.containsKey(i)) {
      sortedPiles.add(piles[i]);
    }
  }

  return sortedPiles;
}