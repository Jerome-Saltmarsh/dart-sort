void testSplitSort() {
  // splitSort([7, 4, 12, 10, 11, 1, 12, 2]);
  splitSort([7, 4, 500, 12, 10, 11, 1, 12, 2, 5, 20, 3, 9, 14, 99, 35, 4]);
}

void splitSort(List<int> list) {
  // print(list);
  int pivot = list.length ~/ 2;
  _splitSort(list, 0, pivot);
  _splitSort(list, pivot, list.length - 1);
  mergePivots(list, pivot);
}

void _splitSort(List<int> list, int left, int right) {
  if (left + 1 == right) {
    if (list[left] > list[left + 1]) {
      int val = list[left];
      list[left] = list[left + 1];
      list[left + 1] = val;
      // print(list);
    }
    return;
  }

  int pivot = (left + right) ~/ 2;
  _splitSort(list, left, pivot);
  _splitSort(list, pivot, right);
  mergePivots(list, pivot);
}

void mergePivots(List<int> list, int pivot) {
  int swaps = 0;
  while (pivot + swaps < list.length && pivot -1 - swaps > 0 && list[pivot + swaps] < list[pivot - 1 - swaps]) {
    swaps++;
  }

  if(swaps == 0) return;

  for (int i = 0; i < swaps; i++) {
    int val1 = list[pivot - i - 1];
    int val2 = list[pivot + swaps - i - 1];
    list[pivot - i - 1] = val2;
    list[pivot + swaps - i - 1] = val1;
    // print(list);
  }

  // mergePivots(list, pivot - swaps);
  // mergePivots(list, pivot + swaps);
}
