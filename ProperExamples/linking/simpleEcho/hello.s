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
.extern print_string
.type print_string function
.extern _exit
.type _exit function

.text

main:
    push %rbp
    mov %rsp, %rbp
    leaq helloworld(%rip), %rdi
    call print_string
    mov $0, %rdi
    call _exit

.data
helloworld: .asciz "Hello World!\n"
