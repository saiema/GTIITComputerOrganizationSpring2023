# Linking example

Start with these two files

```C
/* main.c */
#include <stdio.h> /* for printf() */

extern char* hello(void);

int main(void)
{
    printf("%s\n", hello());
    return 0;
}
```

```C
/* hello.c */
#define hi "Hello world"

char *hello(void)
{
    return hi;
}
```

## Preprocessing

Execute `gcc -E hello.c -o hello.i` and `gcc -E main.c -o main.i` to see how the preprocessor modifies the code.

## Compilation (from C to Assembly)

Execute `gcc -S hello.i -o hello.s` and `gcc -S main.i -o main.s` to see how the compiler generates assembly from C code.

## Assembling

Execute `gcc -c hello.s -o hello.o` and `gcc -c main.s -o main.o` to see the object files generated.

## Linking

Execute `gcc main.o hello.o -o hello` to get the final executable.
