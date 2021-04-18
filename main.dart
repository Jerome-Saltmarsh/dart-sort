import 'dart-sort.dart';
import 'items.dart';

void main() {
  items = generate_random_list(100000);
  time_function(master_sort_items, name: 'master-sort ${items.length} items');
  // randomize();
  // timeFunction(testOfficialSort, name: 'Official ${randomItems.length}');
  // print(items);
}

void shuffle_items(){
  items.shuffle();
}

void master_sort_items(){
  master_sort(items);
}

void quick_sort_items(){
  quiick_sort(items);
}

