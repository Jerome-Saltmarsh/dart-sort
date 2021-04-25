import 'dart:math';

import 'main.dart';

void quick_sort(List<int> list) {
  list.sort(compare_ints);
}

int compare_ints(int a, int b) {
  if (a > b) {
    return 1;
  }
  if (a < b) {
    return -1;
  }
  return 0;
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

  int sectionWidth = range ~/ 4;

  int abPivot = min + sectionWidth;
  int bcPivot = abPivot + sectionWidth;
  int cdPivot = bcPivot + sectionWidth;

  int aSize = 0;
  int bSize = 0;
  int cSize = 0;

  for (int i = 0; i < length; i++) {
    if (list[i] < abPivot) {
      aSize++;
    } else if (list[i] < bcPivot) {
      bSize++;
    } else if (list[i] < cdPivot) {
      cSize++;
    }
  }

  // print('min: $min, max: $max, range: $range, abPivot: $abPivot, bcPivot: $bcPivot, aSize:$aSize, bSize: $bSize, cSize:${length - aSize - bSize}');

  int indexA = 0;
  int indexB = aSize;
  int indexC = aSize + bSize;
  int indexD = aSize + bSize + cSize;

  int value = list[length - 1];
  int swapValue = -1;

  while (true) {
    swapValue = value;
    if (value < abPivot) {
      while (list[indexA] < abPivot) {
        indexA++;
      }
      value = list[indexA];
      list[indexA] = swapValue;
    } else if (value < bcPivot) {
      while (list[indexB] >= abPivot && list[indexB] < bcPivot) {
        indexB++;
      }
      value = list[indexB];
      list[indexB] = swapValue;
    } else if (value < cdPivot) {
      while (list[indexC] >= bcPivot && list[indexC] < cdPivot) {
        indexC++;
      }
      value = list[indexC];
      list[indexC] = swapValue;
    } else {
      while (list[indexD] >= cdPivot) {
        indexD++;
        if (indexD == length) {
          if (sectionWidth > 16) {
            masterSortBounded(list, 0, aSize, min, abPivot);
            masterSortBounded(list, aSize, aSize + bSize, abPivot, bcPivot);
            masterSortBounded(list, aSize + bSize, length, bcPivot, max);
          } else {
            insertionSort(list, 0, aSize);
            insertionSort(list, aSize, aSize + bSize);
            insertionSort(list, aSize + bSize, length);
          }
          return;
        }
      }
      value = list[indexD];
      list[indexD] = swapValue;
    }
  }
}

void masterSortBounded(List<int> list, int start, int end, int min, int max) {
  int range = max - min;
  if (range <= 1) return;

  int firstOutOfPlaceIndex = -1;
  for (int i = start; i < end - 1; i++) {
    if (list[i] > list[i + 1]) {
      firstOutOfPlaceIndex = i + 1;
      break;
    }
  }
  if (firstOutOfPlaceIndex == -1) return; // the list is in order

  // todo the range determines how many pivots are needed
  int sectionWidth = range ~/ 4;
  int pivotAB = min + sectionWidth;
  int pivotBC = pivotAB + sectionWidth;
  int pivotCD = pivotBC + sectionWidth;
  if (pivotAB == pivotBC) return;

  int sizeA = 0;
  int sizeB = 0;
  int sizeC = 0;

  for (int i = start; i < end; i++) {
    if (list[i] < pivotAB) {
      sizeA++;
    } else if (list[i] < pivotBC) {
      sizeB++;
    } else if (list[i] < pivotCD) {
      sizeC++;
    }
  }

  int length = end - start;
  int sizeD = length - sizeA - sizeB - sizeC;
  // print('min: $min, max: $max, range: $range, abPivot: $abPivot, bcPivot: $bcPivot, aSize:$aSize, bSize: $bSize, cSize:${length - aSize - bSize}');

  int indexA = start;
  int indexB = start + sizeA;
  int indexC = indexB + sizeB;
  int indexD = indexC + sizeC;

  int value = list[start];
  int swapValue = -1;

  int finish = 100;
  while (true) {
    swapValue = value;
    if (value < pivotAB) {
      while (list[indexA] < pivotAB) {
        indexA++;
        if (indexA >= sizeA) return;
      }
      value = list[indexA];
      list[indexA] = swapValue;
      // print("$value replaced ${swapValue} at indexA: $indexA. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    } else if (value < pivotBC) {
      while (list[indexB] >= pivotAB && list[indexB] < pivotBC) {
        indexB++;
        if (indexB >= sizeB) return;
      }
      value = list[indexB];
      list[indexB] = swapValue;
      // print("$value replaced ${swapValue} at indexB: $indexB. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    } else if (value < pivotCD) {
      while (list[indexC] >= pivotBC && list[indexC] < pivotCD) {
        indexC++;
        if (indexC >= sizeC) return;
      }
      value = list[indexC];
      list[indexC] = swapValue;
      // print("$value replaced ${swapValue} at indexC: $indexB. sizes[$sizeA, $sizeB, $sizeC], finish: $finish, length: $length, pivots:[$min, $pivotAB, $pivotBC, $max]");
    } else {
      while (list[indexD] >= pivotCD) {
        indexD++;
        if (indexD >= finish) {
          if (sizeA > 10) {
            masterSortBounded(list, start, start + sizeA, min, pivotAB);
          } else {
            insertionSort(list, start, start + sizeA);
          }
          if (sizeB > 10) {
            masterSortBounded(
                list, start + sizeA, start + sizeA + sizeB, pivotAB, pivotBC);
          } else {
            insertionSort(list, start + sizeA, start + sizeA + sizeB);
          }
          if (sizeC > 10) {
            masterSortBounded(
                list, start + sizeA + sizeB, end - 1, pivotBC, max);
          } else {
            insertionSort(list, start + sizeA + sizeB, end - 1);
          }
          if (sizeC > 10) {
            masterSortBounded(
                list, start + sizeA + sizeB, end - 1, pivotBC, max);
          } else {
            insertionSort(list, start + sizeA + sizeB, end - 1);
          }
          return;
        }
      }
      value = list[indexD];
      list[indexD] = swapValue;
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



List<int> mSort(List<int> list) {

  DateTime checkpoint0 = DateTime.now();

  int max = list[0];
  int min = list[0];
  List<int> indexes = List.filled(list.length, 0);
  List<int> sortedList = List.filled(list.length, 0);

  DateTime checkpoint1 = DateTime.now();

  var numberOfSections = 10000;

  final sectionSizes = List.filled(numberOfSections + 1, 0);
  final sectionIndexes = List.filled(numberOfSections + 1, 0);

  for (var i = 0; i < list.length; i++) {
    if (list[i] < min) {
      min = list[i];
    } else if (list[i] > max) {
      max = list[i];
    }
  }

  var range = max - min;
  var sectionSize = range / numberOfSections;

  DateTime checkpoint2 = DateTime.now();

  for (var i = 0; i < list.length; i++) {
    var section = (list[i] - min) ~/ sectionSize;
    // todo remove this check
    // if(section == numberOfSections){
    //   section = numberOfSections - 1;
    // }
    sectionSizes[section]++;
    indexes[i] = section;
  }


  DateTime checkpoint3 = DateTime.now();

  var startingIndexes = List.filled(numberOfSections + 1, 0);
  int total = 0;
  for (var i = 0; i < numberOfSections; i++) {
    startingIndexes[i] = total;
    total += sectionSizes[i];
  }


  DateTime checkpoint4 = DateTime.now();

  for (var i = 0; i < list.length; i++) {
    var index = indexes[i];
    int newIndex = sectionIndexes[index] + startingIndexes[index];
    sortedList[newIndex] = list[i];
    sectionIndexes[index]++;
  }


  DateTime checkpoint5 = DateTime.now();

  printDifference('0', checkpoint0, checkpoint1);
  printDifference('1', checkpoint1, checkpoint2);
  printDifference('2', checkpoint2, checkpoint3);
  printDifference('3', checkpoint3, checkpoint4);
  printDifference('4', checkpoint4, checkpoint5);
  return sortedList;
}

