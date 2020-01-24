// simple bubblesort

void sortClassifica(int *array[], int length) {
  bool swapped;
  Pilot *hold;

  do {
    swapped = false;

    for (int i = 1; i < length; i++) {
      if (ranking[i]->time < ranking[i-1]->time) {
        swap(i, i-1);
        swapped = true;
      }
    }

    length--;
  } while (swapped);
}

void swap(byte index1, byte index2) {
  Pilot *hold = ranking[index2];
  ranking[index2] = ranking[index1];
  ranking[index1] = hold;
}
