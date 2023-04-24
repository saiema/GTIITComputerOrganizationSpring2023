#include <stdlib.h>
#include <stdio.h>

void printReceivedMessage(char * msg, int size);
void askAndRespond();

void main(int argc, char ** argv) {
    char secret[11];
    secret[0] = 'p';
    secret[1] = 'a';
    secret[2] = 's';
    secret[3] = 's';
    secret[4] = 'w';
    secret[5] = 'o';
    secret[6] = 'r';
    secret[7] = 'd';
    secret[8] = '1';
    secret[9] = '2';
    secret[10] = '3';
    askAndRespond();
}

void askAndRespond() {
    char receivedString[20];
    printf("Input: ");
    fgets(receivedString, 20, stdin);
    int size;
    printf("Size: ");
    scanf("%d", &size);
    printReceivedMessage(receivedString, size);
}

void printReceivedMessage(char * msg, int size) {
    for (int i = 0; i < size; i++) {
        printf("%c", msg[i]);
    }
    printf("\n");
}