.global main
.type main function

.text

main:
  push %rbp
  mov %rsp, %rbp
  push %rdi       # current index     (-8 %rbp)
  decq -8(%rbp)   # update index to (argc - 1)
  push %rdi       # arguments' size   (-16 %rbp)
  push %rsi       # array's address   (-24 %rbp)
  subq $8, %rsp   # align stack so rsp is a multiple of 16
  jmp moreArguments

printArguments:
  mov -24(%rbp), %r8    # array's address
  mov -8(%rbp), %r9     # index
  leaq format(%rip), %rdi
  mov (%r8, %r9, 8), %rsi
  call printf
  decq -8(%rbp)         # decrease index

moreArguments:
  mov -8(%rbp), %r8    # move the index into r8
  cmpq $0, -8(%rbp)    # compare 0 - index
  jnz printArguments

done:
  add $32, %rsp
  mov $0, %rax
  leave
  ret
  
.data
format: .asciz "%s\n"

