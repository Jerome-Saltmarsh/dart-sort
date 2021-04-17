import 'fast-sort.dart';
import 'items.dart';

void main() {
  randomItems = randomInts(10000);
  // timeFunction(sortRandomItems, name: 'Mega Sort ${randomItems.length} items');
  // randomize();
  timeFunction(testOfficialSort, name: 'Official ${randomItems.length}');
  // print(randomItems);

}

void randomize(){
  randomItems.shuffle();
}

void sortRandomItems(){
  megaSort(randomItems);
}

void testOfficialSort(){
  officialSort(randomItems);
}

void testMySort(){
  megaSort(randomItems);
}

