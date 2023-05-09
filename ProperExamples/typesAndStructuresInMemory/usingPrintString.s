.global main
.type main function
.extern printString
.type printString function

.text

main:
    push %rbp
    mov %rsp, %rbp
    mov $0x0A21216F6C6C6548, %rax
    push %rax
    push $0
    leaq -8(%rbp), %rdi
    call printString
    mov $0, %rax
    leave
    ret
