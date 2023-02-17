  .global _start
  .type _start function
  .extern _print_string
  .type _print_string function
  .extern _printNumberAsString
  .type _printNumberAsString function
  .extern _exit
  .type _exit function

.text

_start:
  push  %rbp
  mov   %rsp, %rbp
  mov 8(%rbp), %rdi
  call _printNumberAsString
  cmpq $3, 8(%rbp)
  jne _wrongInputs
  mov 16(%rbp), %rdi
  mov 24(%rbp), %rsi
  leave
  mov $0, %rdi
  call _exit
  
_compareStrings:
  push %rbp
  mov %rsp, %rbp
  
  leave
  ret
  
_wrongInputs:
  mov $wrongInput, %rdi
  call _print_string
  leave
  mov $0, %rdi
  call _exit
  
.data
wrongInput: .asciz "Wrong amount of inputs\nUsage: ./compareStrings <string> <string>\n"
