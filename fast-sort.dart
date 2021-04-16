import 'dart:math';

List<int> randomInts(int count, [int max = 1000]) {
  List<int> numbers = [];
  Random random = Random.secure();
  for (int i = 0; i < count; i++) {
    numbers.add(random.nextInt(max));
  }
  return numbers;
}

int total = 0;
int i = 0;
int min = -1;
int max = -1;
int pivot = -1;
int itemsUnderPivot = -1;
int xValue = -1;
int yValue = -1;
int x = -1;
int y = -1;

void mySort(List<int> items) {
  sortStartAndEnd(items, 0, items.length);
}

bool isSorted(List<int> items, int start, int end) {
  for (int index = start; index < end - 1; index++) {
    if (items[index] > items[index + 1]) return false;
  }
  return true;
}

void sortStartAndEnd(List<int> items, int start, int end) {
  DateTime flag0 = DateTime.now();

  // calculate pivot
  total = 0;
  while (i < end) {
    total += items[i];
    i++;
  }
  pivot = total ~/ items.length;

  DateTime flag1 = DateTime.now();

  // calculate number of items under pivot
  itemsUnderPivot = 0;
  for (i = start; i < end; i++) {
    if (items[i] < pivot) {
      itemsUnderPivot++;
    }
  }

  if (itemsUnderPivot == 0) return;

  DateTime flag2 = DateTime.now();

  // swap items
  int endX = start + itemsUnderPivot;
  y = endX;
  for (x = start; x < endX; x++) {
    if (items[x] < pivot) {
      continue;
    }
    xValue = items[x];
    while (items[y] >= pivot) {
      y++;
    }
    items[x] = items[y];
    items[y] = xValue;
  }

  DateTime flag3 = DateTime.now();
  printDifference('flag0', flag0, flag1);
  printDifference('flag1', flag1, flag2);
  printDifference('flag2', flag2, flag3);

  // if (end - start < 2) return;

  // if(!isSorted(items, start, itemsUnderPivot)){
  //   sortStartAndEnd(items, start, itemsUnderPivot);
  // }
  // if(!isSorted(items, start + itemsUnderPivot, end)){
  //   sortStartAndEnd(items, start + itemsUnderPivot, end);
  // }
}

void sortStartAndEndPivot(
    List<int> items, int start, int end, int min, int max) {
  pivot = ((min + max) * 0.5).toInt();
  itemsUnderPivot = 0;

  for (i = start; i < end; i++) {
    if (items[i] < pivot) {
      itemsUnderPivot++;
    }
  }

  if (itemsUnderPivot == 0) return;

  y = start + itemsUnderPivot;
  for (x = start; x < start + itemsUnderPivot; x++) {
    if (items[x] < pivot) {
      continue;
    }
    while (items[y] >= pivot) {
      y++;
    }
    xValue = items[x];
    yValue = items[y];
    items[x] = yValue;
    items[y] = xValue;
    // print("swapped $xValue with $yValue at x: $x, y:$y");
    y++;
  }

  // if (end - start <= 2) return;

  // TODO remove call to self
  // sortStartAndEndPivot(items, start, itemsUnderPivot, min, pivot.toInt());
  // sortStartAndEndPivot(items, start + itemsUnderPivot, end, pivot.toInt(), max);
}

int itemCount = 1000000;
List<int> list = randomInts(itemCount);

void randomizeList() {
  list = randomInts(itemCount);
}

void testMySort() {
  mySort(list);
}

void testOfficialSort() {
  officialSort(list);
}

void officialSort(List<int> unsortedList) {
  unsortedList.sort(quickSortInt);
}

int quickSortInt(int a, int b) {
  if (a > b) {
    return 1;
  }
  if (a < b) {
    return -1;
  }
  return 0;
}

void timeFunction(Function function, {String name = 'some function'}) {
  DateTime start = DateTime.now();
  function();
  DateTime finished = DateTime.now();
  Duration duration = finished.difference(start);
  int seconds = duration.inSeconds;
  int milliseconds = duration.inMilliseconds % 1000;
  print("Finished $name in $seconds seconds $milliseconds milliseconds");
}

void printDifference(String name, DateTime a, DateTime b) {
  Duration duration = b.difference(a);
  int seconds = duration.inSeconds;
  int milliseconds = duration.inMilliseconds % 1000;
  print("name: $name, seconds: $seconds, milliseconds:$milliseconds");
}

void insertionSort(List<int> a, int left, int right) {
  for (int i = left + 1; i <= right; i++) {
    var el = a[i];
    int j = i;
    while ((j > left) && (a[j - 1] > el)) {
      a[j] = a[j - 1];
      j--;
    }
    a[j] = el;
  }
}

void megaSort(List<int> list) {
  int length = list.length;
  int lengthMinusOne = length - 1;
  int min = 0;
  int max = 0;

  for (int i = 0; i < length; i++) {
    if (list[i] < min) {
      min = list[i];
    } else if (list[i] > max) {
      max = list[i];
    }
  }

  int range = max - min;
  int sectionWidth = range ~/  3;

  int abPivot = min + sectionWidth;
  int bcPivot = abPivot + sectionWidth;

  int aSize = 0;
  int bSize = 0;

  for (int i = 0; i < length; i++) {
    if (list[i] < abPivot) {
      aSize++;
    } else if (list[i] < bcPivot) {
      bSize++;
    }
  }

  // print('min: $min, max: $max, range: $range, abPivot: $abPivot, bcPivot: $bcPivot, aSize:$aSize, bSize: $bSize, cSize:${length - aSize - bSize}');

  int indexA = 0;
  int indexB = aSize;
  int indexC = aSize + bSize;

  int value = list[length - 1];
  int swapValue = -1;

  while (true) {

    if (value < abPivot) {
      while(list[indexA] < abPivot){
        // print("${list[indexA]} already in section a.");
        indexA++;
      }
      swapValue = value;
      value = list[indexA];
      list[indexA] = swapValue;
      // print("$value swapped with ${swapValue} at $indexA");
    }

    else if (value < bcPivot) {
      while(list[indexB] >= abPivot && list[indexB] < bcPivot){
        indexB++;
      }
      swapValue = value;
      value = list[indexB];
      list[indexB] = swapValue;
    }

    else {
      while(list[indexC] >= bcPivot){
        indexC++;
        if(indexC == lengthMinusOne){
          return;
        }
      }
      swapValue = value;
      value = list[indexC];
      list[indexC] = swapValue;

      if(indexC == lengthMinusOne){
        return;
      }
    }
  }
}
