# How to use the main tools of the course

## Assembly brief introduction.

We will use AT&T assembly in a x86-64 architecture using Linux as our OS (I recommend Ubuntu 20.04 or greater).
Assembly is the simpler programming language that uses CPU instructions, it offer the most simple of abstractions,
assembly operators, often called mnemonics represent operation written in hexadecimal format.

To assemble an assembly program we will use either **as** (_GNU Assembler_) or **gcc** (_GNU C and C++ Compiler_)
using the flag `-c` which indicates that we only want to compile but do not want the linking phase to (occur)[#linking].
This will generate an object file (extension `.o`) which we cannot yet execute. If we want to compile an assembly file,
including the linking phase, we can just execute `gcc <assembly files> -o <executable name>`.

As an example let's consider the code of `42.s` (assembly files have extension `.s` or `.asm`):

```GAS
#42.s
#
#A really simple Hello World program.
#So simple it doesn't print anything.
#
#Compile as: gcc 42.s -z noexecstack -o 42
#Run as: ./42 ; echo $?

.global main
.type main function

.text

main:
  mov $42, %rax
  ret
```

If we assemble this code with either `as 42.s` or `gcc -c 42.s` we will get an object file `42.o`. I we want to make this
object file into an executable we need to link it. In this particular case, the assembly code correspond to the following
**C** code:

```C
#42.c
#
#A really simple Hello World program.
#So simple it doesn't print anything.
#
#Compile as: gcc 42.c -o 42
#Run as: ./42 ; echo $?


int main(void) {
  return 42;
}
```

Now for some linking details (before the linking section): executable files are expected to have a starting function named
**_start**, the assembly code of `42.s` and the C code of `42.c` clearly don't have a function named **_start**. For C,
there is a **_start** function already implemented in the Standard C Library which has the function **_start**, this function
has some simple responsibilities, two of those are: calling a **main** function; exiting the program with the value returned
by that function. How we could make the same assembly code without depending on that **_start** function inside the Standard C
Library? We would need to exit the program ourselves:

```GAS
#42.s
#
#A really simple Hello World program.
#So simple it doesn't print anything.
#
#Assemble as: gcc -c 42.s -o 42.o
#Link: ld 42.o -o 42
#Run as: ./42 ; echo $?

.global _start
.type _start function

.text

_start:
  mov $42, %rdi
  mov $60, %rax
  syscall
```

Here we use a system call, these are calls to functions defined by the OS. These functions are referred to by using an identifying
number. In here, the `exit(int exitCode)` function has **60** as it's identifying number. The argument (**exitCode**) is passed by
using the register **rdi**. The operator used for system calls is called **syscall**, we will see more OS defined function later on.

## Disassembling

We can disassemble either an object file (extension `.o`), or an executable file by using the tool **objdump**.

Using `objdump -D 42.o` we obtain:

```
42.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	48 c7 c0 2a 00 00 00 	mov    $0x2a,%rax
   7:	c3                   	ret
```

Using `objdump -x 42.o` we obtain all headers, sections' information, and symbol table

```
42.o:     file format elf64-x86-64
42.o
architecture: i386:x86-64, flags 0x00000010:
HAS_SYMS
start address 0x0000000000000000

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000008  0000000000000000  0000000000000000  00000040  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  0000000000000000  0000000000000000  00000048  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  0000000000000000  0000000000000000  00000048  2**0
                  ALLOC
SYMBOL TABLE:
0000000000000000 g     F .text	0000000000000000 main
```

## Linking

Any code will have symbols, both internal and external. Some will come from combining other sources, and the address of these
symbols can be then calculated when doing **static linking**. Other symbols, those in shared libraries for example, will have no
known addresses until the program is running and the library is loaded into memory, only then these addresses can be calculated.

As we can see above, the starting address of the **main** function is **0000000000000000**. Let's link our **42.o** to get the
executable **42** and let's disassemble the executable.

To link, we will use the **ld** tool (_GNU Linker_)
