#include <stdio.h>

void skipAssignment(void) {
    int top = 5;
    int  *ret;

    ret = &top + 7;
    (*ret) += 7; //operation at line 16 uses 7 bytes
}

void main() {
    int x;
    x = 0;
    skipAssignment();
    x = 1;
    printf("%d\n",x);
}
