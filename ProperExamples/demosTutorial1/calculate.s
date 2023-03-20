/*
A simple program to practice the use of the stack to define local variables.
In this program we will have 3 local variables, take the first 2, add them up
and then we will add that result to the third variable and return the resulting value
as the program's exit code.

Compile as: gcc calculate.s -z nostackexec -no-pie -o calculate
Run as: ./calculate ; echo $?

note: the -no-pie flag is needed because we are referring to data values
directly, and one security feature that is enabled by default is to have
randomize memory addresses on each execution, but if we did that then the address for
arg1, arg2, and arg3 would change on each execution and we would need to use
relative addresses.
*/

.global main
.type main function

.text

main:
  push %rbp
  mov %rsp, %rbp
  movzbq arg3, %rdi
  push %rdi
  movzbq arg2, %rdi
  push %rdi
  movzbq arg1, %rdi
  push %rdi
  mov -24(%rbp), %rdi
  add -16(%rbp), %rdi
  imul -8(%rbp), %rdi
  mov %rdi, %rax
  sub $24, %rsp
  leave
  ret

.data
arg1: .byte 3
arg2: .byte 4
arg3: .byte 2
