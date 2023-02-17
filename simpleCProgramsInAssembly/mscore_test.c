#include <stdio.h>

long mult2(long x, long y) {
  return x*y;
}

void multscore(long x, long y, long *dest) {
  long t = mult2(x, y);
  *dest = t;
}

void main() {
  long res;
  multscore(2,3,&res);
  printf("%ld\n", res);
}
