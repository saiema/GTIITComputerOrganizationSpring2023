.global main
.type main function

.text

main:
  mov $18, %rax
  sal $1, %rax
  ret
