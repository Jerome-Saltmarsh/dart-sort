import 'dart:math';

List<int> generate_random_list(int count, [int max = 1000]) {
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
List<int> list = generate_random_list(itemCount);

void randomizeList() {
  list = generate_random_list(itemCount);
}

void testMySort() {
  mySort(list);
}

void testOfficialSort() {
  quiick_sort(list);
}

void quiick_sort(List<int> unsortedList) {
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

void time_function(Function function, {String name = 'some function'}) {
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

void insertionSort(List<int> list, int left, int right) {
  for (int i = left + 1; i <= right; i++) {
    var item = list[i];
    int j = i;
    while ((j > left) && (list[j - 1] > item)) {
      list[j] = list[j - 1];
      j--;
    }
    list[j] = item;
  }
}

void master_sort(List<int> list) {
  int length = list.length;
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

  if (range == 0) return;

  int sectionWidth = range ~/ 3;

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
    swapValue = value;
    if (value < abPivot) {
      while (list[indexA] < abPivot) {
        // print("${list[indexA]} already in section a.");
        indexA++;
      }
      value = list[indexA];
      list[indexA] = swapValue;
      // print("$value swapped with ${swapValue} at $indexA");
    } else if (value < bcPivot) {
      while (list[indexB] >= abPivot && list[indexB] < bcPivot) {
        indexB++;
      }
      value = list[indexB];
      list[indexB] = swapValue;
    } else {
      while (list[indexC] >= bcPivot) {
        indexC++;
        if (indexC == length) {
          if (sectionWidth > 16) {
            boundedMegaSort(list, 0, aSize, min, abPivot);
            boundedMegaSort(list, aSize, aSize + bSize, abPivot, bcPivot);
            boundedMegaSort(list, aSize + bSize, length, bcPivot, max);
          } else {
            insertionSort(list, 0, aSize);
            insertionSort(list, aSize, aSize + bSize);
            insertionSort(list, aSize + bSize, length);
          }
          return;
        }
      }
      value = list[indexC];
      list[indexC] = swapValue;
    }
  }
}

void boundedMegaSort(List<int> list, int start, int end, int min, int max) {
  int length = end - start;
  int range = max - min;
  if (range <= 1) return;

  // todo the range determines how many pivots are needed

  int sectionWidth = range ~/ 3;
  int pivotAB = min + sectionWidth;
  int pivotBC = pivotAB + sectionWidth;
  if (pivotAB == pivotBC) return;

  int sizeA = 0;
  int sizeB = 0;

  for (int i = start; i < end; i++) {
    if (list[i] < pivotAB) {
      sizeA++;
    } else if (list[i] < pivotBC) {
      sizeB++;
    }
  }

  int sizeC = length - sizeA - sizeB;
  // print('min: $min, max: $max, range: $range, abPivot: $abPivot, bcPivot: $bcPivot, aSize:$aSize, bSize: $bSize, cSize:${length - aSize - bSize}');

  int indexA = start;
  int indexB = start + sizeA;
  int indexC = indexB + sizeB;

  if(length - 1 >= list.length || length <= 0){
    print('break');
  }

  int firstOutOfPlaceIndex = -1;
  for(int i = start; i < end - 1; i++){
    if(list[i] > list[i + 1]){
      firstOutOfPlaceIndex = i;
      break;
    }
  }
  if (firstOutOfPlaceIndex == -1) return; // the list is in order

  int value = list[end - 1];
  int swapValue = -1;
  int finish = end - 1;
  while (true) {
    swapValue = value;
    if (value < pivotAB) {
      while (list[indexA] < pivotAB) {
        indexA++;
      }
      value = list[indexA];
      list[indexA] = swapValue;
      // print("$value replaced ${swapValue} at indexA: $indexA. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    } else if (value < pivotBC) {
      while (list[indexB] >= pivotAB && list[indexB] < pivotBC) {
        indexB++;
      }
      value = list[indexB];
      list[indexB] = swapValue;
      // print("$value replaced ${swapValue} at indexB: $indexB. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    } else {
      while (list[indexC] >= pivotBC) {
        indexC++;
        if (indexC == finish) {
          if (sizeA > 16) {
            boundedMegaSort(list, start, start + sizeA, min, pivotAB);
          } else {
            insertionSort(list, start, start + sizeA);
          }
          if (sizeB > 16) {
            boundedMegaSort(list, start + sizeA, start + sizeA + sizeB, pivotAB, pivotBC);
          } else {
            insertionSort(list, start + sizeA, start + sizeA + sizeB);
          }
          if (sizeC > 16) {
            boundedMegaSort(list, start + sizeA + sizeB, end - 1, pivotBC, max);
          } else {
            insertionSort(list, start + sizeA + sizeB, end - 1);
          }
          return;
        }
      }
      value = list[indexC];
      list[indexC] = swapValue;
      // print("$value replaced ${swapValue} at indexC: $indexC. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    }
  }
}

/**
 * Only by developing a deep understanding of the different kinds of sorting algorithms can you hope to improve upon them
 *
 * Merge Sort
 *
 * Quick Sort
 *
 * Insertion Sort
 *
 * Bubble Sort
 *
 * Heap Sort
 *
 * Identifying particularly difficult orders to sort.
 *
 * <Algorithm Types>
 *    Divide and Conquer
 *
 *
 * smart html.
 *
 * Design an expressive html language.
 * That would be the most useful tool you could create.
 *
 * Currently html is a mark up language. But its a language without logic.
 *
 * Html Script
 *
 * // code is all lowercase.
 * // String values can contain capitals
 *
 * // html script supports variables
 *
 * // tags are used to instant a class
 * //
 *
 * const world = 'world'
 *
 * <content axis: x main: start cross: end>
 *   <text 'hello'>
 *   <text world> // pass the world variable
 *   build_hello_world('greetings')
 *
 * // write functions
 * hello-world(string message)
 *   <text 'message received'>
 *   <text message>
 * } // set the end of the function
 *
 * <hello-world {message: 'hello'}>
 *
 * // if a composure function only takes a single argument it can be called using the short format
 * <hello-world({message: 'hello'}>
 *
 *  // assign values to variables
 *  test = 'hello this is a test'
 *  <hello-world: test> // call hello world function and pass the variable test
 *
 *  <build-container { int width, int height, hexidecimal color }
 *      area = width * height
 *  >
 *
 *  <customer { first_name: 'foo', last_name: 'bar', age: 35 } >
 *
 * <define customer: {
 *    str first_name
 *    str last_name
 *    int age
 *
 *    const adult: 18
 *
 *    get full_name {
 *      return '$firstname $last_name
 *    }
 * }>
 *
 * // all data is passed as json
 */
