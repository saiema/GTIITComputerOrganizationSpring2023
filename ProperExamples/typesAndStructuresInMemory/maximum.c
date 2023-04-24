#include <stdlib.h>
#include <stdio.h>

int maximum(int values[], int size);

void main (int argc, char ** argv) {
    if (argc > 21) {
        printf("Up to 20 arguments supported (%d)\n", argc);
        exit(1);
    }
    int values[20];
    int i;
    for (i = 0; i < argc - 1; i++) {
        values[i] = atoi(argv[i + 1]);
    }
    int max = maximum(values, argc - 1);
    printf("The maximum number is: %d\n", max);
}

int maximum(int values[], int size) {
    int currentMaximum = -1;
    for (int i = 0; i < size; i++) {
        if (values[i] >= currentMaximum) {
            currentMaximum = values[i];
        }
    }
    return currentMaximum;
}