// Store pass the min and max values to the recursion
void pileIntSort(List<int> unsortedList) {
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
  int defaultIndexCount = 10000;
  int totalIndexes = unsortedList.length > defaultIndexCount
      ? defaultIndexCount
      : unsortedList.length;

  List<List<int>> piles = List(totalIndexes + 1);

  for (int i = 0; i < unsortedList.length; i++) {
    int value = unsortedList[i];
    double indexDouble = ((value - min) / range * totalIndexes);
    int index = indexDouble.toInt();


    if (piles[index] == null) {
      piles[index] = [value];
    } else {
//      piles[index].add(value);
      double remainder = indexDouble % index;
      int l = piles[index].length;
      double subIndex = remainder * piles[index].length * 10;
      int subIndexInt = subIndex.toInt();

      if(remainder < 0.5){
        piles[index].insert(0, value);
      }else{
        piles[index].add(value);
      }
    }
  }

  int currentPile = 0;
  int currentPileIndex = 0;
  for (int i = 0; i < unsortedList.length; i++) {
    while (piles[currentPile] == null) {
      currentPile++;
    }

    unsortedList[i] = piles[currentPile][currentPileIndex];
    currentPileIndex++;

    if (currentPileIndex == piles[currentPile].length) {
      currentPileIndex = 0;
      currentPile++;
    }
  }

  DateTime endTime = DateTime.now();
  Duration duration = endTime.difference(startTime);
}

void tradeSort(List<int> values) {
  int min = values[0];
  int max = values[0];

  for (int i = 1; i < values.length; i++) {
    if (values[i] < min) {
      min = values[i];
    } else if (values[i] > max) {
      max = values[i];
    }
  }

  int range = max - min;
  int defaultIndexCount = 10000;
  int totalIndexes =
      values.length > defaultIndexCount ? defaultIndexCount : values.length;

  Function getIndexOf = (int val) {
    return ((val - min) / range * totalIndexes).toInt();
  };

  int value = values[0];
  int targetIndex = getIndexOf(value);
//  swapInto(values, value, targetIndex, getIndexOf);
  print("Swaps $totalSwaps");

  while (true) {
    int placeHolder = values[targetIndex];
    int placeHoldersIndex = getIndexOf(placeHolder);

    if (placeHoldersIndex != targetIndex) {
      values[targetIndex] = value;
      print("Swapped value: $value into index: $targetIndex");
      value = placeHolder;
      targetIndex = placeHoldersIndex;
    } else {
      if (placeHolder == value) {
        bool positionFound = false;
        while (targetIndex >= 0) {
          targetIndex--;
          int lowerVal = values[targetIndex];
          if (lowerVal > value) {
            // swap the value into the lower val's position
            positionFound = true;
            break;
          }
        }
        if (!positionFound) {
          while (targetIndex < values.length) {
            targetIndex++;
            int lowerVal = values[targetIndex];
            lowerVal < value;
            break;
          }
        }
      }
    }
  }
}

int totalSwaps = 0;

Function swapInto =
    (List<int> values, int value, int index, Function getIndexOf) {
  totalSwaps++;

  if (index >= values.length) {
//    throw Exception("What?");
    index--;
  }
  int placeHolder = values[index];
  int placeHoldersIndex = getIndexOf(placeHolder);

  if (placeHoldersIndex != index) {
    values[index] = value;
    print("Swapped value: $value into index: $index");
    swapInto(values, placeHolder, placeHoldersIndex, getIndexOf);
    return;
  }

  if (placeHolder == value) {
    int searchIndex = index;
    while (searchIndex < values.length) {
      print("SearchIndex $searchIndex");
      int valueAtSearchIndex = values[searchIndex];
      if (valueAtSearchIndex == value) {
        searchIndex++;
      } else {
        if (valueAtSearchIndex < value) {
          int nextIndex = getIndexOf(valueAtSearchIndex);
          swapInto(values, valueAtSearchIndex, nextIndex, getIndexOf);
          return;
        } else {
          print("Breaking");
          break;
        }
      }
    }

    while (searchIndex >= 0) {
      print("SearchIndex $searchIndex");
      int valueAtSearchIndex = values[searchIndex];
      if (valueAtSearchIndex == value) {
        searchIndex--;
      } else {
        if (valueAtSearchIndex > value) {
          int nextIndex = getIndexOf(valueAtSearchIndex);
          swapInto(values, valueAtSearchIndex, nextIndex, getIndexOf);
          return;
        }
      }
    }

    print("Reached end");
    return;
  }

  // if the place holder already is in the correct index
  if (placeHolder > value) {
    swapInto(values, value, index - 1, getIndexOf);
    return;
  }
  if (placeHolder < value) {
    swapInto(values, value, index + 1, getIndexOf);
    return;
  }
};
