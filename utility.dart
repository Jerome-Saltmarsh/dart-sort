
import 'dart:math';

void errorCheck(List<double> sortedNumbers, List<double> unsortedList) {
  if (sortedNumbers.length != unsortedList.length) {
    throw Exception(
        "Numbers missing. Found ${sortedNumbers.length}, expected ${unsortedList.length}");
  }

  for (int i = 0; i < sortedNumbers.length - 1; i++) {
    if (sortedNumbers[i] > sortedNumbers[i + 1]) {
      throw Exception(
          "Out of order index: $i, ${sortedNumbers[i]} ${sortedNumbers[i + 1]}");
    }
  }
}


List<int> generateRandomInts(
    {int total = 100, int max = 1000, bool includeNegatives = true}) {

  print("Generating $total Random Numbers List");
  Random random = Random(DateTime.now().microsecond);
  List<int> unsortedList = List(total);
  for (int i = 0; i < total; i++) {
    int value = random.nextInt(max);
    if (includeNegatives) {
      if (random.nextBool()) {
        value = -value;
      }
    }
    unsortedList[i] = value;
  }
  return unsortedList;
}

List<double> generateRandomDoubles(
    {int total = 100, int max = 1000, bool includeNegatives = true}) {

  print("Generating Random List");
  Random random = Random(DateTime.now().microsecond);
  List<double> unsortedList = List();
  for (int i = 0; i < total; i++) {
    double value = random.nextDouble() * max;
    if (includeNegatives) {
      if (random.nextBool()) {
        value = -value;
      }
    }

    unsortedList.add(value);
  }
  print("Generating Random List Finished");
  return unsortedList;
}

String toText(Duration duration){
  return "${duration.inSeconds} seconds ${duration.inMilliseconds % 1000} milliseconds";
}