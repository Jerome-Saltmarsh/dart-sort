import 'sort_double.dart';
import 'sort_int.dart';
import 'utility.dart';

int totalArraysCreated = 0;
int comparisons = 0;
int calls = 0;

void main() {
  const int total = 10000000;

//  List<double> unsortedList = generateRandomDoubles(total: total, max: 1);
  List<int> unsortedInts = generateRandomInts(total: total, max: 1000);

  try {
    print("Starting Sort of $total numbers");
    DateTime start = DateTime.now();
//    testQuickSortInt(unsortedInts);
    List<List<int>> results = testPileSortInt(unsortedInts);
    DateTime finished = DateTime.now();
    Duration duration = finished.difference(start);
//  print(unsortedList);
//    List sortedPiles = pileSortDouble(unsortedList);

    int seconds = duration.inSeconds;
    int milliseconds = duration.inMilliseconds % 1000;
    print(results);
    print("Sort Finished in $seconds seconds $milliseconds milliseconds");

//    List<double> sortedNumbers = pilesToList(sortedPiles);
//    errorCheck(unsortedList, unsortedList);
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

void testPileSort(List<double> unsortedList) {
  pilesToList(pileSortDouble(unsortedList));
}

List<List<int>> testPileSortInt(List<int> unsortedList) {
  return pileIntSort(unsortedList);
}

void testQuickSortDouble(List<double> unsortedList) {
  unsortedList.sort(quicksortDouble);
}

void testQuickSortInt(List<int> unsortedList) {
  unsortedList.sort(quickSortInt);
}

int quicksortDouble(double a, double b) {
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
