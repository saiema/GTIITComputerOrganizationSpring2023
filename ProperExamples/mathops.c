#include <stdio.h>
#include <stdlib.h>

#define PLUSONE 1
#define MINUSONE 2
#define DOUBLE 3
#define HALF 4
#define ZERO 5
#define NEGATIVE 6
#define ABSOLUTE 7

int applyOperation(int init, int op);
int applyOperations(int init, int ops[], int opsSize);

void main(void) {
  int init = 2;
  printf("Plus one: %d\n", applyOperation(init, PLUSONE));
  printf("Minus one: %d\n", applyOperation(init, MINUSONE));
  printf("Double: %d\n", applyOperation(init, DOUBLE));
  printf("Half: %d\n", applyOperation(init, HALF));
  printf("Zero: %d\n", applyOperation(init, ZERO));
  printf("Negative: %d\n", applyOperation(init, NEGATIVE));
  printf("Absolute: %d\n", applyOperation(init, ABSOLUTE));
  printf("Default: %d\n", applyOperation(init, -1));
  printf("Double of plus one: %d\n", applyOperation(applyOperation(init, PLUSONE), DOUBLE));
  int ops[] = {PLUSONE, DOUBLE};
  printf("Double of plus one: %d\n", applyOperations(init, ops, 2));
}

int applyOperations(int init, int ops[], int opsSize) {
  int opIdx = 0;
  int result = init;
  while (opIdx < opsSize) {
    result = applyOperation(result, ops[opIdx]);
    opIdx++;
  }
  return result;
}

int applyOperation(int init, int op) {
  switch(op) {
    case PLUSONE: return init + 1;
    case MINUSONE: return init - 1;
    case DOUBLE: return init * 2;
    case HALF: return (int) init / 2;
    case ZERO: return 0;
    case NEGATIVE: return init * - 1;
    case ABSOLUTE: init >= 0? init : init * - 1;
    default: return init;
  }
}
