  .global _start
  .type _start function
  .extern _printNumberAsString
  .type _printNumberAsString function
  .extern _exit
  .type _exit function
  
.text

_start:
  /*Let's get max of a and b*/
  mov %rsp, %rbp
  xor %rdi, %rdi
  xor %rsi, %rsi
  movzbq zero, %rdi
  movzbq two, %rsi
  push %rdi #saves the value (-8%rbp)
  push %rsi #saves the flags (-16%rbp)

_max_using_conditional_jumps:
  mov -8(%rbp), %rdi
  call _printNumberAsString
  mov -16(%rbp), %rdi
  call _printNumberAsString
  mov -8(%rbp), %rdi
  mov -16(%rbp), %rsi
  call _max_jmp
  mov %rax, %rdi
  call _printNumberAsString
  
_max_using_conditional_move:
  mov -8(%rbp), %rdi
  call _printNumberAsString
  mov -16(%rbp), %rdi
  call _printNumberAsString
  mov -8(%rbp), %rdi
  mov -16(%rbp), %rsi
  call _max_cond_mov
  mov %rax, %rdi
  call _printNumberAsString

_done:
  add $16, %rsp
  leave
  call _exit
  
/*
A simple max function of two numbers
Implemented with conditional jumps
*/
_max_jmp:
  push %rbp
  mov %rsp, %rbp
  cmp %rdi, %rsi # b - a
  jge _max_jmp_b
  mov %rdi, %rax
  jmp _max_jmp_done

_max_jmp_b:
  mov %rsi, %rax

_max_jmp_done:
  leave
  ret
  
/*
A simple max function of two numbers
Implemented with conditional jumps
*/
_max_cond_mov:
  push %rbp
  mov %rsp, %rbp
  cmp %rdi, %rsi # b - a
  mov %rdi, %rax
  cmovge %rsi, %rax
  leave
  ret
  
/*
A simple function to determine if
a value A is greater or equal than
a value B.
*/
_ge:
  push %rbp
  mov %rsp, %rbp
  cmp %rdi, %rsi # B - A
  setge %rax
  leave
  ret
  


.data
two: .byte 2
three: .byte 3
zero: .byte 0

