  .global _start
  .type _start function
  .extern _power_n
  .type _power_n function
  .extern _printNumberAsString
  .type _printNumberAsString function
  .extern _exit
  .type _exit function
  
.text

_start:
  /*Let's get power of 2 to 3*/
  mov %rsp, %rbp
  xor %rdi, %rdi
  xor %rsi, %rsi
  movzbq zero, %rdi
  movzbq zero, %rsi
  push %rdi #saves the value (-8%rbp)
  push %rsi #saves the flags (-16%rbp)
  mov -8(%rbp), %rdi
  call _printNumberAsString
  mov -16(%rbp), %rdi
  call _printNumberAsString
  mov -8(%rbp), %rdi
  mov -16(%rbp), %rsi
  call _power_n
  mov %rax, %rdi
  call _printNumberAsString
  add $16, %rsp
  leave
  call _exit


.data
two: .byte 2
three: .byte 3
zero: .byte 0

