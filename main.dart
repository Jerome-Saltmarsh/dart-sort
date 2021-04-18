import 'dart:math';

import 'dart-sort.dart';
import 'items.dart';

void main() {
  items = generate_random_list(10000);
  time_function(master_sort_items, name: 'master-sort ${items.length} items');
  // time_function(quick_sort_items, name: 'Official ${items.length}');
  // print(items);
}

void shuffle_items(){
  items.shuffle();
}

void master_sort_items(){
  master_sort(items);
}

void quick_sort_items(){
  quick_sort(items);
}

List<int> generate_random_list(int count, [int max = 1000]) {
  List<int> numbers = [];
  Random random = Random.secure();
  for (int i = 0; i < count; i++) {
    numbers.add(random.nextInt(max));
  }
  return numbers;
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