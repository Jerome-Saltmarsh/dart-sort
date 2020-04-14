
List<List<int>> pileIntSort(List<int> unsortedList) {

  int length = unsortedList.length;
  int min = unsortedList[0];
  int max = unsortedList[0];

  for (int i = 0; i < length; i++) {
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
  int maxIndex = (length - 1);

  for (int i = 0; i < length; i++) {

    int index = (((unsortedList[i] - min) / range) * maxIndex).toInt();

    if (piles.containsKey(index)) {
      piles[index].add(unsortedList[i]);
    } else {
      piles[index] = [unsortedList[i]];
    }
  }

  List<List<int>> sortedPiles = List();

  for (int i = 0; i < maxIndex; i++) {
    if (piles.containsKey(i)) {
      sortedPiles.add(piles[i]);
    }
  }

  return sortedPiles;
}
