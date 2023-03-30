.global main
.type main function

.text

main:
  mov $1, %rdi
  mov $2, %rsi
  add %rdi, %rsi
  leaq printFormat(%rip), %rdi
  xor %rax, %rax
  #mov $printFormat, %rdi
  call printf
  ret
  
.data
printFormat: .asciz "%d\n"
