#include <stdio.h>
#include <stdlib.h>

void main(void) {
  void * p = malloc(8);
  *((int *)p) = 5;
  int * pvalue = (int *) p;
  int value = *pvalue;
  printf("%d\n", value);
}
