#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

int main(void) {
    pid_t pid;
    int x = 1;

    pid = fork();
    if (pid == 0) { /*Child*/
        x++;
        printf("Child: x = %d\n", x);
        exit(42);
    }

    /*Parent*/
    if (pid > 0) {
        int waitstatus;
        printf("Parent will wait for child %d\n", pid);
        wait(&waitstatus);
        printf("Child %d died with exit code %d\n", pid, WEXITSTATUS(waitstatus));
    }
    printf("Parent: x = %d\n", x);
    exit(0);
}