#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "key_values.h"
#include "key_value_constants.h"

int isKey(char * input) {
  if (strlen(input) > 2) {
    return input[0] == '-' && input[1] == '-';
  }
  return 0;
}

char** getKeyValuePair(char * input) {
  char** key_value_pair = (char**) malloc(sizeof(char *) * 2);
  key_value_pair[0] = getStringUntilSymbol(input, '=');
  key_value_pair[1] = getStringFromSymbol(input, '=');
  return key_value_pair;
}

int indexOfChar(char * input, char symbol) {
  int length  = strlen(input);
  if (length  == 0) {
    return -1;
  }
  int idx = 0;
  int found = 0;
  do {
    if (input[idx] == symbol) {
      found = 1;
    } else {
      idx++;
    }
  } while (idx < length  && !found);
  return found ? idx : -1;
}

char * getStringUntilSymbol(char * input, char symbol) {
  int length = strlen(input);
  if (length == 0) {
    return "\0";
  }
  int index_of_symbol = indexOfChar(input, symbol);
  return index_of_symbol >= 0?substring(input, 0, index_of_symbol):"\0";
}

char * getStringFromSymbol(char * input, char symbol) {
  int length = strlen(input);
  if (length == 0) {
    return "\0";
  }
  int index_of_symbol = indexOfChar(input, symbol);
  return index_of_symbol >= 0?substring(input, index_of_symbol + 1, length):"\0";
}

char * substring(char * input, int init, int end) {
  int length = strlen(input);
  if (init >= end) {
    return "\0";
  }
  if (init < 0 || end < 0) {
    return "\0";
  }
  if (init >= length) {
    return "\0";
  }
  int copy_max = end < length?end:length;
  int substring_length = (copy_max - init) + 1;
  char * substring = (char *) malloc(sizeof(char)*substring_length);
  substring[substring_length - 1] = '\0';
  int idx = 0;
  while ((idx + init) < copy_max) {
    substring[idx] = input[idx + init];
    idx++;
  }
  return substring;
}

char * getKeyName(char * input) {
  //remove the two `-`, add one more to NULL terminate the string
  return substring(input, 2, strlen(input));
}
