import 'fast-sort.dart';
import 'items.dart';

void main() {
  randomItems = randomInts(100000);
  timeFunction(sortRandomItems, name: 'sort Random items ${randomItems.length}');
  // randomize();
  // timeFunction(testOfficialSort, name: 'Officialt ${randomItems.length}');
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

