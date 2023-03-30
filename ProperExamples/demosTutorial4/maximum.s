/*
This program implements a function maximum that returns the maximum of an array of length N.
Both the array and the size is given as arguments.

To further modularize our code, we will also implement a function max, which will take two numbers and return
the maximum of the two.

To compile the code run: gcc maximum.s -z nostackexec -no-pie -o maximum
To run the code run: ./maximum ; echo $?

To debug the code add the flag -ggdb to the compilation command, and the run gdb maximum
*/

.global main
.type main function

.text

main:
  push %rbp
  mov %rsp, %rbp
  push $1       # -8
  push $3       # -16
  push $22      # -24
  push $155     # -32
  push $0       # -40
  push size     # -48
  leaq -40(%rbp), %rdi
  mov -48(%rbp), %rsi
  call maximum
  jmp cleanAndReturn
  
cleanAndReturn:
  pop %rdi
  jmp moreElementsToClean
  
cleanElement:
  add $8, %rsp
  sub $1, %rdi

moreElementsToClean:
  cmp $0, %rdi
  jne cleanElement
  
return:
  leave
  ret
  
maximum:
  push %rbp
  mov %rsp, %rbp
  push %rdi                 # array (-8)
  push %rsi                 # size of the array (-16)
  pushq $0                  # element counter (or can be considered as an index) (-24)
  mov $0, %rax              # current maximum
  jmp evaluateNextMaximum

updateMaximum:
  mov -8(%rbp), %r8   # current element of the array
  movq (%r8), %rdi
  mov %rax, %rsi        # current maximum
  call max
  addq $8, -8(%rbp)
  addq $1, -24(%rbp)

evaluateNextMaximum:
  mov -16(%rbp), %r8
  mov -24(%rbp), %r9
  cmp %r8, %r9
  jne updateMaximum

cleanMaximumStack:
  add $24, %rsp
  
returnMaximum:
  leave
  ret

max:
  push %rbp
  mov %rsp, %rbp
  cmp %rsi, %rdi
  mov %rsi, %rax
  cmovge %rdi, %rax
  leave
  ret
  
.data
size: .quad 5
