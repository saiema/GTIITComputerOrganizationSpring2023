/*
Given an unsigned number value, calculate the next even number.
For example, for 3, the next even number is 4; for 6 the next
even number is 8.

Compile as: gcc nextEven.s -z noexecstack -no-pie -o nextEven
Run as: ./nextEven ; echo $?

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
  mov value, %dil
  mov value, %sil
  and $1, %sil
  test $1, %sil
  jne is_odd
  
is_even:
  add $2, %dil
  jmp done
  
is_odd:
  add $1, %dil
  
done:
  mov %dil, %al
  leave
  ret

.data
value: .byte 3
