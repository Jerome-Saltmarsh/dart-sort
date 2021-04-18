import 'dart-sort.dart';
import 'items.dart';

void main() {
  randomItems = randomInts(10000);
  timeFunction(megaSortItems, name: 'Mega Sort ${randomItems.length} items');
  // randomize();
  // timeFunction(testOfficialSort, name: 'Official ${randomItems.length}');
  // print(randomItems);
}

void randomize(){
  randomItems.shuffle();
}

void megaSortItems(){
  megaSort(randomItems);
}

void quickSortItems(){
  officialSort(randomItems);
}

