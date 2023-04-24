#include <stdlib.h>
#include <stdio.h>

void printReceivedMessage(char * msg, int size);

void main(int argc, char ** argv) {
    if (argc != 3) {
        printf("Incorrect amount of arguments (%d)\nUsage is ./heartbleed <string> <integer>\n", argc);
        exit(1);
    }
    char * receivedString = argv[1];
    int size = atoi(argv[2]);
    printReceivedMessage(receivedString, size);
}

void printReceivedMessage(char * msg, int size) {
    for (int i = 0; i < size; i++) {
        printf("%c", msg[i]);
    }
    printf("\n");
}