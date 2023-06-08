#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <string.h>

int evaluateInput(char input);
void cleanByte(int fd);

void main(int argc, char ** argv) {
    if (argc != 2) {
        puts("Wrong amount of arguments\nUsage: ./sleepyFileReader <path to file>");
        exit(1);
    }
    char * filename = argv[1];
    int fd = open(filename, O_RDWR | O_CREAT);
    if (fd < 0) {
        printf("An error occurred while opening file (%s): %s\n", filename, strerror(errno));
        exit(2);
    }
    int run = 1;
    while(run) {
        char byteRead;
        int fseekresult = lseek(fd, 0, SEEK_SET);
        if (fseekresult != 0) {
            printf("An error occurred while setting offset to 0: %s\n", strerror(errno));
            exit(3);
        }
        int bytesRead = read(fd, &byteRead, 1);
        if (bytesRead == 0) {
            puts("Read 0 bytes");
        } else if (byteRead < 0) {
            printf("An error occurred while reading: %s\n", strerror(errno));
            exit(4);
        }
        run = evaluateInput(byteRead);
        cleanByte(fd);
        sleep(2);
    }
}

void cleanByte(int fd) {
    int fseekresult = lseek(fd, 0, SEEK_SET);
    if (fseekresult != 0) {
        printf("An error occurred while setting offset to 0: %s\n", strerror(errno));
        exit(3);
    }
    char zero = 0;
    int bytesWritten = write(fd, &zero, 1);
    if (bytesWritten == 0) {
        puts("Could not write a 0 to the file (but no error ocurred) exiting just in case");
        exit(5);
    } else if (bytesWritten < 0) {
        printf("An error occurred while writting 0 to the file: %s\n", strerror(errno));
        exit(6);
    }
}

int evaluateInput(char input) {
    switch (input) {
        case 'H' :
        case 'h' : {
            puts("Hello to you too!");
            return 1;
        }

        case 'E':
        case 'e':
        case 'X':
        case 'x': {
            puts("Quitting, have a nice day!");
            return 0;
        }
        case 'T':
        case 't': {
            time_t rawtime;
            struct tm * timeinfo;
            time(&rawtime);
            timeinfo = localtime(&rawtime);
            printf("Current time is: [%d %d %d %d:%d:%d]\n", timeinfo->tm_mday,
                    timeinfo->tm_mon + 1, timeinfo->tm_year + 1900,
                    timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
            return 1;
        }
        case 0: {
            return 1;
        }
        default: {
            printf("I don't understand what '%c' is\n", input);
            return 1;
        }
    }
}
