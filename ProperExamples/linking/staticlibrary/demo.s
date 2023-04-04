/*
A simple echo program.
This program will print the amount of arguments in argv and print them (including the executable path).
To compile this program execute:
1. Generate the static library astd (this only need to be generated once unless a change is made)
    gcc [-ggdb] -c -z noexecstack string.s -o string.o
    gcc [-ggdb] -c -z noexecstack stdutils.s -o stdutils.o
    ar rcs libastd.a stdutils.o string.o
2. Compile the executable
    gcc [-ggdb] -z noexecstack demo.s -L "$PWD" -l astd -o demo

To run the program you need to execute:
    ./demo (string)*

note 1: [-ggdb] stands for: "optionally you can write -ggdb"
note 2: (string)* stands for: "zero or more strings"

example:
    ./demo "This" "are" "the" "arguments"
    
    will print
    
    Number of arguments: 5
    Argument[0]: ./demo
    Argument[1]: This
    Argument[2]: are
    Argument[3]: the
    Argument[4]: arguments
*/


.global main
.type main function
.extern _print_integer
.extern _print_string
.type _print_integer function
.type _print_string function
.extern _exit
.type _exit function

.text

main:
    push %rbp
    mov %rsp, %rbp
    push %rdi # argc (%rbp - 8)
    push %rsi # argv (%rbp - 16)
    push $0   # index (i) (%rbp - 24)
    leaq nargsmsg(%rip), %rdi
    call _print_string
    mov -8(%rbp), %rdi
    mov $1, %rsi            /*  <--------
                            The second argument of _print_integer
                            will define wether or not to print a
                            new-line character after the number
                            */
    call _print_integer
    leaq newline(%rip), %rdi
    call _print_string
    jmp printArguments_test

/*
This subroutine will print "Argument[i]: argv[i]"
*/
printArguments:
    leaq argmsg_init(%rip), %rdi
    call _print_string
    mov -24(%rbp), %rdi
    mov $0, %rsi
    call _print_integer
    leaq argmsg_end(%rip), %rdi
    call _print_string
    mov -16(%rbp), %r8      # argv
    mov -24(%rbp), %r9      # i
    mov %r9, %rdi
    mov (%r8, %r9, 8), %rdi # argv[i] (this address is calculated by doing argv + (i * 8))
    call _print_string
    leaq newline(%rip), %rdi
    call _print_string
    incq -24(%rbp)          # i++


printArguments_test:
    mov -8(%rbp), %r8
    cmp %r8, -24(%rbp)
    jnz printArguments

done:
    mov $0, %rdi
    call _exit

.data
nargsmsg: .asciz "Number of arguments: "
newline: .asciz "\n"
argmsg_init: .asciz "Argument["
argmsg_end: .asciz "]: "
