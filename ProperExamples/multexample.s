  .global _start
  .type _start function
  .extern _printNumberAsString
  .type _printNumberAsString function
  .extern _exit
  .type _exit function
  .text
  
_start:
        #x = 4 in %rdi
        #y = 3 in %rsi
        #z = 2 in %rdx
        
        mov xvalue, %rdi
        mov yvalue, %rsi
        mov zvalue, %rdx
        call _scale_using_leaq
        mov %rax, %rdi
        call _printNumberAsString
        mov $0, %rdi
        call _exit

/*
This subroutine will calculate rdi + 4 * rsi + 12 * rdx
*/
_scale:
  imul $4, %rsi   # rsi = 4 * rsi
  imul $12, %rdx  # rdx = 12 * rdx
  addq %rsi, %rdi # rdi = rdi + 4 * rsi
  addq %rdx, %rdi # rdi + 4 * rsi + 12 * rdx
  mov %rdi, %rax  # As convention, the result should be stored in rax
  ret
  
_scale_using_leaq:
  leaq (%rdi, %rsi, 4), %rax
  leaq (%rdx, %rdx, 2), %rdx
  leaq (%rax, %rdx, 4), %rax
  ret   
        
.data
xvalue: .quad 4
yvalue: .quad 3
zvalue: .quad 2
