#include <stdlib.h>
#include <stdio.h>

#define GREET "Greetings"
#define WRONG_ARGS "Wrong number of arguments"
#define USAGE "Usage: ./greetings <string>"
#define GOOD_LUCK "Good luck with "

char * getGoal(void);

void main(int argc, char * argv[]) {
  if (argc == 2) {
    printf("%s %s\n", GREET, argv[1]);
    printf("%s%s\n", GOOD_LUCK, getGoal()); 
    exit(0);
  } else {
    printf("%s (%d)\n%s\n", WRONG_ARGS, argc, USAGE);
    exit(1);
  }
}

char * getGoal(void) {
  char * goal = malloc(sizeof(char) * 30);
  printf("Please tell me your current goal: ");
  scanf("%[^\n]s", goal);
  return goal;
}
