/*
A hello world program.
This program will print "Hello World!" in the standard output.
To compile this program execute:
    gcc [-ggdb] -z noexecstack hello.s string.s stdutils.s -o hello

To run the program you need to execute:
    ./hello

note 1: [-ggdb] stands for: "optionally you can write -ggdb"

*/


.global main
.type main function
.extern print_integer
.type print_integer function

.text

main:
    push %rbp
    mov %rsp, %rbp
    mov $1, %rax
    mov $56, %rdi
    mov $helloworld, %rsi
    mov $13, %rdx
    syscall
    push %rax
    mov $1, %rax
    mov $1, %rdi
    mov $printedcharacters, %rsi
    mov $20, %rdx
    syscall
    pop %rdi
    mov $1, %rsi
    call print_integer
    mov $60, %rax
    mov $0, %rdi
    syscall
    
.data
helloworld: .asciz "Hello World!\n"
printedcharacters: .asciz "Printed characters: "
