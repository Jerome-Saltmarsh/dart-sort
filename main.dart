import 'sort_double.dart';
import 'utility.dart';

int totalArraysCreated = 0;
int comparisons = 0;
int calls = 0;

void main() {
  const int total = 10000000;
  print("Generating Random List");
  List<double> unsortedList = generateRandomDoubles(total: total, max: 1);
//  print(unsortedList);
  try {
    print("Starting Sort");
    List sortedPiles = pileSortDouble(unsortedList);
    print("Sort Finished");
    List<double> sortedNumbers = pilesToList(sortedPiles);
    errorCheck(sortedNumbers, unsortedList);
//    print("Sorted Piles");
//    print(sortedNumbers);
//    print(sortedNumbers);
    print("Total Elements: $total");
    print("Total Arrays: $totalArraysCreated");
    print("Total Calls: $calls");
  } catch (e) {
    print(e);
  }
}


