#include<stdlib.h>
#include<stdio.h>
#include<string.h>

#define HELLO_THERE 0
#define THE_ANSWER_TO_EVERYTHING 1

/*
* Given a NULL terminated string that represent a specific key,
* this function will return a natural number constant unique for
* this key.
*/
int getConstant(char * str) {
  if (strcmp(str, "Hello there\0") == 0) {
    return HELLO_THERE;
  } else if (strcmp(str, "What's the answer to life, the universe, and everything there is?") == 0) {
    return THE_ANSWER_TO_EVERYTHING;
  } else {
    return -1;
  }
}

/*
* Determines whether a string matches the format of --<string>
* Precondition: the string must be NULL terminated.
* Usage examples:
* isKey("-Key") returns 0
* isKey("--") returns 0
* isKey("--a") returns 1
*/
int isKey(char * str) {
  if (strlen(str) > 2) {
    return str[0] == '-' && str[1] == '-';
  }
  return 0;
}

/*
* Given a string that is considered a key, it removes
* the first two middle dashes.
* Precondition: input str is a key, this means it's
* at least 3 characters long, starting with "--".
*/
char * getKeyName(char * str) {
  //remove the two `-`, add one more to NULL terminate the string
  int substringLength = (strlen(str) - 2) + 1;
  char * substring = malloc(sizeof(char)*substringLength);
  substring[substringLength - 1] = '\0';
  int i = 0;
  int offset = 2;
  do {
    substring[i] = str[i + offset];
    i++;
  } while(i + offset < substringLength);
  return substring;
}

/*
* This program takes arguments in the form of <key>=<value>
* where <key> is a string with at least 3 characters starting with
* "--" and do different things according to these key-value pairs.
*/
void main(int argc, char ** argv) {
  for (int i = 1; i < argc; i++) {
    switch(getConstant(argv[i])) {
      case HELLO_THERE : {
        printf("General Kenobi\n");
        break;
      }
      case THE_ANSWER_TO_EVERYTHING : {
        printf("42\n");
        break;
      }
      default : {
        printf("And \"%s\" to you too!\n", argv[i]);
      }
    }
  }
}
