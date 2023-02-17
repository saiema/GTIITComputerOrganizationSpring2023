#include <stdlib.h>
#include <stdio.h>

static char * mallocFailed = "Malloc failed\0";
static char * mallocSucceded = "Malloc succeded\0";

void main(void) {
  void * p = malloc(4);
  if (p == NULL) {
    printf("%s\n", mallocFailed);
  } else {
    printf("%s\n", mallocSucceded);
  }
}
