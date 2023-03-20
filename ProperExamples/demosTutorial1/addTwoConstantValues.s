.global main
.type main function

.text

main:
  mov $1, %rdi
  mov $2, %rsi
  add %rdi, %rsi
  mov %rsi, %rax
  ret
