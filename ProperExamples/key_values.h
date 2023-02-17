/*
* Determines whether a string matches the format of --<string>
* Precondition: the string must be NULL terminated.
* Usage examples:
* isKey("-Key") returns 0
* isKey("--") returns 0
* isKey("--a") returns 1
*/
int isKey(char * input);

/*
* Given a NULL terminated string that has two strings separated
* by an equal (=) character, this function will return an array of
* size two with the two strings.
* Usage examples:
* getKeyValuePair("a=b\0") returns ["a\0", "b\0"]
* getKeyValuePair("a=\0") returns ["a\0", "\0"]
* getKeyValuePair("a\0") returns ["a\0, "\0"]
* getKeyValuePair("\0") returns ["\0", "\0"]
*/
char** getKeyValuePair(char * input);

/*
* Given a NULL terminated string, this function will return
* the prefix of the string until a particular symbol (excluding).
*/
char * getStringUntilSymbol(char * input, char symbol);

/*
* Given a NULL terminated string, this function will return
* the suffix of the string from a particular symbol (excluding).
*/
char * getStringFromSymbol(char * input, char symbol);

/*
* Given a NULL terminated string and a symbol, this function
* will return the first index such as str[idx] == symbol.
* It will return -1 if the symbol can't be found.
*/
int indexOfChar(char * input, char symbol);

/*
* Given a NULL terminated string, a starting and ending index
* this function will return a substring starting from the
* starting index, including, until the final index, excluding. 
*/
char * substring(char * input, int init, int end);

/*
* Given a string that is considered a key, it removes
* the first two middle dashes.
* Precondition: input str is a key, this means it's
* at least 3 characters long, starting with "--".
*/
char * getKeyName(char * input);
