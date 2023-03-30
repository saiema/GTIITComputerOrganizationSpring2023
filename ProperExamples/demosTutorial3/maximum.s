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
  push $1
  push $3
  push $22
  push $0
  push size
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
  sub $24, %rsp
  mov 16(%rbp), %r8
  mov %r8, -8(%rbp)        #size of the array
  movq $24, -16(%rbp)      #offset of the first element of the array
  movq $0, -24(%rbp)       #element counter (or can be considered as an index)
  mov $0, %rax             #current maximum
  jmp evaluateNextMaximum

updateMaximum:
  mov -16(%rbp), %rsi
  mov (%rbp, %rsi), %rdi  #current element of the array
  mov %rax, %rsi          #current maximum
  call max
  addq $8, -16(%rbp)
  addq $1, -24(%rbp)

evaluateNextMaximum:
  mov -24(%rbp), %r8
  mov -8(%rbp), %r9
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
size: .quad 4
