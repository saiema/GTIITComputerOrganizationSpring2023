.global main
.type main function
.extern printBook
.type printBook function

.text

main:
    push %rbp
    mov %rsp, %rbp
    pushq lastUserID(%rip)  # -8 (%rbp)
    sub $8, %rsp            # -16 (%rbp)
    mov lended(%rip), %eax
    mov %eax, -12(%rbp)
    mov bookID(%rip), %eax            
    mov %eax, -16(%rbp)
    leaq author(%rip), %rax
    push %rax               # -24 (%rbp)
    leaq title(%rip), %rax
    push %rax               # -32 (%rbp)
    call printBook
    mov $0, %rax
    leave
    ret

.data
title: .asciz "The book of many things"
author: .asciz "Mathew Mercer"
bookID: .long 42
lended: .long 0
lastUserID: .long 73
