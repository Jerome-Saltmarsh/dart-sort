import 'sort_double.dart';
import 'sort_int.dart';
import 'utility.dart';

int totalArraysCreated = 0;
int comparisons = 0;
int calls = 0;

void main() {
  const int total = 10000000;

//  List<double> unsorted = generateRandomDoubles(total: total, max: 1000);
  List<int> unsorted = generateRandomInts(total: total, max: 1000);

  print('unsorted lenght ${unsorted.length}');

  try {
//    List<List<int>> results = testPileSortInt(unsorted);
//    List results = testPileSortDouble(unsorted);
//    List sortedPiles = pileSortDouble(unsortedList);
    var results = pileIntSort(unsorted);
    testQuickSortInt(unsorted);




//      print(results);
//     testQuickSortDouble(unsorted);

//    List<double> sortedNumbers = pilesToList(sortedPiles);
//    List<double> sorted = pilesToList(results);
//    errorCheck(sorted, unsorted);
//    print("Sorted Piles");
//    print(unsortedList);
//    print(sortedNumbers);
//    print("Total Elements: $total");
//    print("Total Arrays: $totalArraysCreated");
//    print("Total Calls: $calls");
  } catch (e) {
    print(e);
  }
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
