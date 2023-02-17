#include <stdio.h>

static int two = 2;
static int three = 3;

int power_n(int a, int b);

void main(void) {
  int power_two_three = power_n(two, three);
  printf("%d^%d = %d\n", two, three, power_two_three);
}

int power_n(int a, int b) {
  static int x = 0;
  if (b == 0) {
    return 1;
  } else if (a == 0) {
    return 0;
  }
  int res = a;
  do {
    res *= a;
    b--;
  } while (b != 1);
}
