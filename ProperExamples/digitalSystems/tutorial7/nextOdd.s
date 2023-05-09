.global main
.extern integerToString
.type main Function
.type integerToString Function

.text

main:
    /*
    int value = X (hardcoded)
    int nextOdd = nextOdd(value)
    integerToString(nextOdd)
    */

nextOdd:
    push %rbp
    mov %rsp, %rbp
    /*
    TODO: complete
    */
    leave
    ret
 
isEven:
    push %rbp
    mov %rsp, %rbp
    mov $0, %r9
    xor %rdx, %rdx
    mov %rdi, %rax
    div $2
    cmp $1, %rdx
    cmovne $1, %r9
    mov %r9, %rax
    leave
    ret
