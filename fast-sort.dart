import 'dart:math';

List<int> randomInts(int count, [int max = 1000]) {
  List<int> numbers = [];
  Random random = Random.secure();
  for (int i = 0; i < count; i++) {
    numbers.add(random.nextInt(max));
  }
  return numbers;
}

int i;
int min;
int max;
double pivotValue;
int itemsUnderPivot;
int xValue;
int yValue;
int x;
int y;

void sort(List<int> items) {
  sortStartAndEnd(items, 0, items.length);
}

void sortStartAndEnd(List<int> items, int start, int end) {
  min = items[start];
  max = items[start];

  // TODO only do this for first iteration, than pass limits down
  for (i = start; i < end; i++) {
    if (items[i] < min) {
      min = items[i];
    } else if (items[i] > max) {
      max = items[i];
    }
  }

  if (min == max) return;

  pivotValue = (min + max) * 0.5;
  itemsUnderPivot = 0;

  for (i = start; i < end; i++) {
    if (items[i] < pivotValue) {
      itemsUnderPivot++;
    }
  }

  if (itemsUnderPivot == 0) return;

  // print(
  //     "{start: $start, end: $end, min:$min, max:$max, 'pivot-value: $pivotValue, items-under-pivot-value: $itemsUnderPivot");
  y = start + itemsUnderPivot;
  for (x = start; x < start + itemsUnderPivot; x++) {
    if (items[x] < pivotValue) {
      continue;
    }
    while (items[y] >= pivotValue) {
      y++;
    }
    xValue = items[x];
    yValue = items[y];
    items[x] = yValue;
    items[y] = xValue;
    // print("swapped $xValue with $yValue at x: $x, y:$y");
    y++;
  }

  if (end - start <= 2) return;

  // TODO remove call to self
  sortStartAndEnd(items, start, itemsUnderPivot);
  sortStartAndEnd(items, start + itemsUnderPivot, end);
}

void main() {
  List<int> list = randomInts(100);
  print('*** random ***');
  print(list);
  sort(list);
  print('*** sorted *** ');
  print(list);
}
