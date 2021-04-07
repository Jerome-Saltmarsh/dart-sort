import 'block_sort.dart';
import 'sort_double.dart';
import 'utility.dart';


void main() {
  List<int> unsorted = generateRandomInts(total: 1000, max: 1000, includeNegatives: true);

  timeFunction((){
//    List(100000000);
//    List.filled(100000000, 0);
//    skipAndSwap(unsorted);
    skipAndSort(unsorted);
//    unsorted.sort();
  });

//  print(unsorted);
}

dynamic testPileSortDouble(List<double> unsortedList) {
  print("Starting PileSort of ${unsortedList.length} numbers");
  DateTime start = DateTime.now();
  var sorted = pileSortDouble(unsortedList);
  DateTime finished = DateTime.now();
  Duration duration = finished.difference(start);
  int seconds = duration.inSeconds;
  int milliseconds = duration.inMilliseconds % 1000;
  print("PileSort Finished in $seconds seconds $milliseconds milliseconds");
  return sorted;
}

void timeFunction(Function function) {
  DateTime start = DateTime.now();
  function();
  DateTime finished = DateTime.now();
  Duration duration = finished.difference(start);
  int seconds = duration.inSeconds;
  int milliseconds = duration.inMilliseconds % 1000;
  print("Finished in $seconds seconds $milliseconds milliseconds");
}


//void testSortedIns(List<int>)

List<double> testQuickSortDouble(List<double> unsortedList) {
  print("Starting QuickSort of ${unsortedList.length} numbers");
  DateTime start = DateTime.now();
  unsortedList.sort(quicksortAlgorithmDouble);
  DateTime finished = DateTime.now();
  Duration duration = finished.difference(start);
  int seconds = duration.inSeconds;
  int milliseconds = duration.inMilliseconds % 1000;
  print("QuickSort Finished in $seconds seconds $milliseconds milliseconds");
  return unsortedList;
}

void testQuickSortInt(List<int> unsortedList) {
  print("Testing Quick Sort Int");
  timeFunction(() {
    unsortedList.sort(quickSortInt);
  });
}

int quicksortAlgorithmDouble(double a, double b) {
  if (a > b) {
    return 1;
  }
  if (a < b) {
    return -1;
  }
  return 0;
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

void insertionSort(List<int> list) {
  // If the same method could have both positional and named optional
  // parameters, this should be (list, [start, end], {compare}).

  for (int pos = 1; pos < list.length; pos++) {
    int min = 0;
    int max = pos;
    var element = list[pos];
    while (min < max) {
      int mid = min + ((max - min) >> 1);
      if (element < list[mid]) {
        max = mid;
      } else {
        min = mid + 1;
      }
    }
    list.setRange(min + 1, pos + 1, list, min);
    list[min] = element;
  }
}
