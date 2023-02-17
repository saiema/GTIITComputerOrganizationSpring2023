#include <stdio.h>
#include <stdlib.h>

int sumElements(int values[], int elems);

void main(void) {
  int values[] = {1,2,3,4,5,6,7,8,9};
  int elems = (int) (sizeof(values)/sizeof(int));
  int sumRes = sumElements(values, elems);
  printf("sum: %d\n", sumRes);
}


int sumElements(int values[], int elems) {
  int sum = 0;
  for (int i = 0; i < elems; i++) {
    sum += values[i];
  }
  return sum;
}
