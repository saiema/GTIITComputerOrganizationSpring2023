/*
Simple program to check whether a flag is present in a value.

Compile as: gcc flags.s -z nostackexec -no-pie -o flags
Run as: ./flags ; echo $?

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
  mov flag4, %dil
  mov value, %sil
  and %dil, %sil
  sete %al
  leave
  ret

.data
flag1: .byte 1
flag2: .byte 2
flag4: .byte 4
flag8: .byte 8
value: .byte 5
