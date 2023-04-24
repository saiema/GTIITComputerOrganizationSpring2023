#include <stdlib.h>
#include <stdio.h>

void updateData(char * receivedData);

void main(int argc, char ** argv) {
    if (argc != 2) {
        printf("Incorrect amount of arguments (%d)\nUsage is ./arrayReadAndWrite <string>\n", argc);
        exit(1);
    }
    updateData(argv[1]);
}

void updateData(char * receivedData) {
    char store[20] = "My initial data";
    char safeData[20] = "sensitive data!";
    int i = 0;
    while (receivedData[i] != 0) {
        store[i] = receivedData[i];
        i++;
    }
    printf("My stored data is now: %s\n", store);
    printf("My sensitive data is still: %s\n", safeData);
}