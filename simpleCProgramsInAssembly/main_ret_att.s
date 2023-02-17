.global _start
.type _start, function

.text

_start:
  mov $42, %rax
  mov %rax, %rdi
  mov $60, %rax
  syscall
