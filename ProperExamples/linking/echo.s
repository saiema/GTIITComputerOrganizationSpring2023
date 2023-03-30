.global main
.type main function

.text

main:
  push %rbp
  mov %rsp, %rbp
  push $8   #offset (skip the first one)
  push %rdi #arguments' size
  decq -16(%rbp)
  push %rsi
  jmp moreArguments

printArguments:
  mov -8(%rbp), %r9 #offset
  mov $format, %rdi
  mov -24(%rbp), %r8
  mov (%r8, %r9), %rsi
  xor %rax, %rax
  call printf
  addq $8, -8(%rbp) #increase offset by 8
  decq -16(%rbp)

moreArguments:
  cmpq $0, -16(%rbp)
  jnz printArguments

done:
  add $24, %rsp
  mov $0, %rax
  leave
  ret
  
.data
format: .asciz "%s\n"
