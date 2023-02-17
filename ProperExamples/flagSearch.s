  .global _start
  .type _start function
  .extern _check_flags
  .type _check_flags function
  .extern _printNumberAsString
  .type _printNumberAsString function
  .extern _exit
  .type _exit function
  
.text

.equ FLAG1, 1       #00000001
.equ FLAG2, 2       #00000010
.equ FLAG4, 4       #00000100
.equ FLAG8, 8       #00001000
.equ FLAG16, 16     #00010000
.equ FLAG32, 32     #00100000

_start:
  /*Let's search flags 1 and 2 in value2*/
  mov %rsp, %rbp
  xor %rdi, %rdi
  xor %rsi, %rsi
  movzbq value2, %rdi
  movb $FLAG1, %sil
  or $FLAG2, %rsi
  push %rdi #saves the value (-8%rbp)
  push %rsi #saves the flags (-16%rbp)
  mov -8(%rbp), %rdi
  call _printNumberAsString
  mov -16(%rbp), %rdi
  call _printNumberAsString
  mov -8(%rbp), %rdi
  mov -16(%rbp), %rsi
  call _check_flags
  mov %rax, %rdi
  call _printNumberAsString
  add $16, %rsp
  leave
  call _exit


.data
value1: .byte 7 #00000111
value2: .byte 4 #00000100
value3: .byte 43 #00101011

