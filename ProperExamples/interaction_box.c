#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "key_value_constants.h"
#include "key_values.h"

#define VERSION 1.0

char * jokes[] = {
  "Why did the console chicken crossed the street?\nTo render the other side!\n",
  "Knock knock!\nWho's there?\nDoctor!\nDoctor Who?\nExactly!\n",
  "What's the thing about Switzerland?\nI don't know, but the flag is a big plus!\n",
  "Helvetica and Times New Roman walk into a bar...\nThe bartender shouts, get out of here!\nWe don't serve your type!\n",
  "Did you hear about the new restaurant called Karma?\nThere's no menu, you get what you deserve\n",
  "A woman in labor suddenly shouted, \"Shouldn't! Wouldn't! Couldn't! Didn't! Can't!\"\nDon't worry said the Doctor, those are just contractions\n",
  "Did you hear about the claustrophobic astronaut?\nHe just needed a little space\n",
  "Why don't scientists trust atoms?\nBecause they make up everything\n",
  "How do you drown a hipster?\nThrow him in the mainstream\n",
  "Why can't you explain puns to kleptomaniacs?\nThey always take things literally\n",
  "Why don't Calculus majors throw house parties?\nBecause you should never drink and derive\n",
  "What do you call a fake noodle?\nAn impasta!\n",
  "Why is 6 afraid of 7?\nBecause 7 8 9\n",
  "What did the shark say when he ate the clownfish?\nThis tastes a little funny\n"
};

int jokes_length = 14;

/*
* Given a NULL terminated string that represent a specific key,
* this function will return a natural number constant unique for
* this key.
*/
int getConstantForKey(char * key_name) {
  if (strcmp(key_name, GREETINGS_KEY) == 0) {
    return GREETINGS_OP;
  } else if (strcmp(key_name, JOKE_KEY) == 0) {
    return JOKE_OP;
  } else if (strcmp(key_name, QUIT_KEY) == 0) {
    return QUIT_OP;
  } else {
    return -1;
  }
}

/*
* Prints a random joke
*/
char * printRandomJoke() {
  int joke_idx = rand() % (jokes_length);
  printf("%s\n", jokes[joke_idx]);
}

void printUsage() {
  printf("interaction_box version %lf\nThis is a simple program that can \
  either greet, tell jokes, and quit with a goodbye message according to \
  the command line arguments used\n\nUsage: ./interaction_box ARGUMENT( \
  ARGUMENT)*\nWhere each ARGUMENT correspond to one of the following:\
  \n\t--greet=name\t:\twill print a greeting using the provided name\
  \n\t--joke=amount\t:\twill tell <amount> random jokes\
  \n\t--quit=message\t:\twill stop evaluating arguments, print a message and quit.\n", VERSION);
}

/*
* Given an operation code, and a related value, this function
* will execute the associated operation using the related value.
* This function will return 0 if it was not a \"quit\" operation,
* and 1 otherwise.
*/
int executeOperation(int op, char * value) {
  int stop = 0;
  switch (op) {
      case GREETINGS_OP : {
        printf("Greetings \"%s\"!\n", value);
        break;
      }
      case JOKE_OP : {
        int jokes = atoi(value); //should be replaced by a better function
        for (int j = 0; j < jokes; j++) {
          printRandomJoke();
          printf("\nHa ha ha!\n");
        }
        break;
      }
      case QUIT_OP : {
        printf("Quitting...\n%s\n", value);
        stop = 1;
        break;
      }
      default : {
        printf("Operation \"%d\" is not a valid one\n", op);
        printUsage();
        exit(3);
      }
    }
    return stop;
}

/*
* Given a raw argument which should follow the format --<string>=<string>
* this function will treat the argument accordingly.
* This function will return 0 if it was not a \"quit\" operation,
* and 1 otherwise.
*/
int treatArgument(char * arg) {
  char ** key_value_pair = getKeyValuePair(arg);
  char * key = key_value_pair[0];
  char * value = key_value_pair[1];
  if (isKey(key)) {
    char * key_name = getKeyName(key);
    return executeOperation(getConstantForKey(key_name), value);
  } else {
    printf("Expecting a key, \"%s\" do not follow the key format \"--<string>\"\n", key);
    exit(2);
  }
}

/*
* This program takes arguments in the form of <key>=<value>
* where <key> is a string with at least 3 characters starting with
* "--" and do different things according to these key-value pairs.
* Usage:
* ./interaction_bob ARGUMENT+
* where ARGUMENT is:
* --KEY=VALUE
* Possible KEY=VALUE are:
*    greet=name : greets using the provided name
*    joke=count : tell <count> random jokes
*    quit=message : prints the message and quits (no further arguments will be evaluated)
*/
void main(int argc, char ** argv) {
  if (argc < 2) {
    printUsage();
    printf("\nToo few arguments!\n");
    exit(1);
  }
  srand ( time(NULL) );
  int stop = 0;
  for (int i = 1; i < argc && !stop; i++) {
    stop = treatArgument(argv[i]);
  }
}
