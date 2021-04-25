import 'dart:math';

import 'dart-sort.dart';
import 'items.dart';
import 'split-sort.dart';

int swaps = 0;
int comparisons = 0;

void main() {
  items = generate_random_list(10000);
  // tSplit();
  time_function(testMSort, name: 'm-sort ${items.length} items');
  // print(items);
  // items = items;
  // // time_function(master_sort_items, name: 'master-sort ${items.length} items');
  // time_function(quick_sort_items, name: 'Official ${items.length}');
  // time_function(good_sort_items, name: 'Good Sort ${items.length}');
  // time_function(testSortMany, name: 'Good Sort ${items.length}');
  // // insertionSort(items, 0, items.length - 1);
  // print(items);

  // List<int> list8 = [0, 12, 5, 8, 8, 3, 9, 10];
  // sort8Indexes(list8, 0, 1, 2, 3, 4, 5, 6, 7);

  // List<int> list16 = [
  //   5,
  //   112,
  //   5,
  //   18,
  //   8,
  //   25,
  //   9,
  //   10,
  //   32,
  //   4,
  //   22,
  //   88,
  //   16,
  //   45,
  //   31,
  //   5
  // ];
  // sort16Indexes(list16, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);


  // print(list8);

  // print('swaps: $swaps, comparisons: $comparisons');
}

void testMSort(){
  mSort(items);
}

void tSplit(){
  splitSort(items);
}

void testSortMany(){
  items = items;
  int margin = items.length ~/ 16;

  for (int x = 0; x < margin; x++) {
    sort16Indexes(
        items,
        x,
        x + margin,
        x + margin * 2,
        x + margin * 3,
        x + margin * 4,
        x + margin * 5,
        x + margin * 6,
        x + margin * 7,
        x + margin * 8,
        x + margin * 9,
        x + margin * 10,
        x + margin * 11,
        x + margin * 12,
        x + margin * 13,
        x + margin * 14,
        x + margin * 15);
  }
}

/**
 * An extremely efficient sorting algorithm
 */
bool sort2Indexes(List<int> list, int i1, int i2) {
  int v1 = list[i1];
  int v2 = list[i2];
  comparisons++;
  if (list[i1] > list[i2]) {
    list[i2] = v1;
    list[i1] = v2;
    swaps++;
    // print(list);
    return true;
  }
  return false;
}

void sort4Indexes(List<int> list, int i1, int i2, int i3, int i4) {
  sort2Indexes(list, i1, i2);
  sort2Indexes(list, i3, i4);
  if (sort2Indexes(list, i2, i3)) {
    if (sort2Indexes(list, i1, i4)) {
      sort2Indexes(list, i3, i4);
    }
  }
}

void sort8Indexes(List<int> list, int i1, int i2, int i3, int i4, int i5,
    int i6, int i7, int i8) {
  sort4Indexes(list, i1, i2, i3, i4);
  sort4Indexes(list, i5, i6, i7, i8);
  sort4Indexes(list, i3, i4, i5, i6);
  sort4Indexes(list, i1, i2, i3, i4);
  sort4Indexes(list, i5, i6, i7, i8);
  sort4Indexes(list, i3, i4, i5, i6);
  sort4Indexes(list, i5, i6, i7, i8);
}

void sort16Indexes(
    List<int> list,
    int i1,
    int i2,
    int i3,
    int i4,
    int i5,
    int i6,
    int i7,
    int i8,
    int i9,
    int i10,
    int i11,
    int i12,
    int i13,
    int i14,
    int i15,
    int i16) {
  sort8Indexes(list, i1, i2, i3, i4, i5, i6, i7, i8);
  sort8Indexes(list, i9, i10, i11, i12, i13, i14, i15, i16);

  if (sort2Indexes(list, i8, i9)) {
    if (sort2Indexes(list, i7, i10)) {
      if (sort2Indexes(list, i6, i11)) {
        sort2Indexes(list, i5, i12);
      }
    }
  }

  sort8Indexes(list, i1, i2, i3, i4, i5, i6, i7, i8);
  sort8Indexes(list, i9, i10, i11, i12, i13, i14, i15, i16);

  if (sort2Indexes(list, i8, i9)) {
    if (sort2Indexes(list, i7, i10)) {
      if (sort2Indexes(list, i6, i11)) {
        sort2Indexes(list, i5, i12);
      }
    }
  }

  sort2Indexes(list, 0, 1);

  // print([
  //     list[i1],
  //     list[i2],
  //     list[i3],
  //     list[i4],
  //     list[i5],
  //     list[i6],
  //     list[i7],
  //     list[i8],
  //     list[i9],
  //     list[i10],
  //     list[i11],
  //     list[i12],
  //     list[i13],
  //     list[i14],
  //     list[i15],
  //     list[i16]]);
}

void shuffle_items() {
  items.shuffle();
}

void master_sort_items() {
  master_sort(items);
}

void quick_sort_items() {
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


