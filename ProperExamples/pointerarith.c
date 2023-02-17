#include <stdio.h>

int main()
{
    int a[5] = {1, 2, 3, 4, 5};
    int i;

    printf("sizeof(a)=%ld, sizeof(a[0])=%ld\n", sizeof(a), sizeof(a[0]));

    for (i=0; i<5; i++)
        printf("a[%d]=%d, &a[%d]=%p\n", i, *(a+i), i, a+i);
}
