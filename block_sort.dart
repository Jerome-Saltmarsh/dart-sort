
List<int> gentleSort(List<int> values) {
  int length = values.length;
  int min = values[0];
  int max = values[0];

  int total = 0;

  for (int i = 1; i < values.length; i++) {
    total += values[i];

    if (values[i] < min) {
      min = values[i];
    } else if (values[i] > max) {
      max = values[i];
    }
  }

  int range = max - min;
  double mid = min + (range / 2);

  int leftSize = 0;
  int rightSize = 0;

  for(int i = 0; i < values.length; i++){
    if(values[i] < mid){
      leftSize++;
    }else{
      rightSize++;
    }
  }


  for (int i = 0; i < length; i++) {
    // int index = ((values[valueIndex] - min) / range * totalIndexes).toInt();
    int value = values[i];

    if(values[i] < mid){

    }else{

    }
  }
}



List<int> blockSort(List<int> values){

  int min = values[0];
  int max = values[0];

  for (int i = 1; i < values.length; i++) {
    if (values[i] < min) {
      min = values[i];
    } else if (values[i] > max) {
      max = values[i];
    }
  }


  List<int> indexed = List(values.length); // D
  List<int> occurrences = List(values.length); // This solves identical indexes
  int range = max - min;
  int totalIndexes = values.length - 1;

  for(int i = 0; i < values.length; i++){

    int index =  ((values[i] - min) / range * totalIndexes).toInt();

    if(occurrences[index] != null){
      if(indexed[index] != values[i]){
        print("Conflict(indexed:${indexed[index]}, value:${values[i]}");
      }

      occurrences[index]++;
    }else
      occurrences[index] = 1;
      indexed[index] = values[i];
  }

  int currentIndex = 0;
  for(int i = 0; i < indexed.length; i++){
    if(indexed[i] != null){
      for(int j = 0; j < occurrences[i]; j++){
        values[currentIndex] = indexed[i];
        currentIndex++;
      }
    }
  }

  return values;

}



List<int> skipAndSwap(List<int> values){

  int min = values[0];
  int max = values[0];

  for (int i = 1; i < values.length; i++) {
    if (values[i] < min) {
      min = values[i];
    } else if (values[i] > max) {
      max = values[i];
    }
  }

  List<List<int>> stacks = [
    List(values.length)
  ];
  // ves identical indexes
  int range = max - min;
  int totalIndexes = 100;
  int indexLength = values.length ~/ totalIndexes;

  for(int valueIndex = 0; valueIndex < values.length; valueIndex++){

    int index =  ((values[valueIndex] - min) / range * totalIndexes).toInt();
    bool found = false;

    for(int row = 0; row < stacks.length; row++){
      if(found){
        break;
      }
      for(int column = index; column < index + indexLength; column++){
        if(stacks[row][column] == null){
          stacks[row][column] = values[valueIndex];
          found = true;
          break;
        }
      }
    }

    if(!found){
      List<int> newStack = List(values.length);
      newStack[index] = values[index];
      stacks.add(newStack);
    }
  }

  int currentIndex = 0;

  for(int sectionIndex = 0; sectionIndex < totalIndexes; sectionIndex++){
    bool ended = false;

    for(int row = 0; row < stacks.length; row++){
      if(ended){
        break;
      }
      int startingIndex = sectionIndex * indexLength;
      int endingIndex = (sectionIndex + 1) * indexLength;

      for(int column = startingIndex; column < endingIndex; column++){
        if(stacks[row][column] != null){
          values[currentIndex] = stacks[row][column];
          currentIndex++;
        }else{
          ended = true;
          break;
        }
      }
    }
  }

  return values;

}



List<int> skipAndSort(List<int> values){

  int length = values.length;
  int min = values[0];
  int max = values[0];

  int total = 0;

  for (int i = 1; i < values.length; i++) {
    total += values[i];

    if (values[i] < min) {
      min = values[i];
    } else if (values[i] > max) {
      max = values[i];
    }
  }

  double average = total / length;
  int range = max - min;
  double mid = min + (range / 2);

  List<int> indexedValues = List(length);
  List<int> quantities = List(length);

  int totalIndexes = 100;
  int indexLength = length ~/ totalIndexes;

  for(int valueIndex = 0; valueIndex < length; valueIndex++){

    int index =  ((values[valueIndex] - min) / range * totalIndexes).toInt();
    if(indexedValues[index] == null){
      indexedValues[index] = values[valueIndex];
      quantities[index] = 1;
    }else{
      for(int i = index + 1; i < index + indexLength; i++){

        if(indexedValues[i] == null){
          indexedValues[i] = values[valueIndex];
          quantities[i] = 1;
          break;
        }
        if(indexedValues[i] == values[valueIndex]){
          quantities[i]++;
          break;
        }
      }
    }
  }

  int currentIndex = 0;

  for(int i = 0; i < indexedValues.length; i++){
    if(indexedValues[i] != null){
      for(int i = 0; i < quantities[i]; i++){
        values[currentIndex] = indexedValues[i];
      }
    }
  }

  return values;

}