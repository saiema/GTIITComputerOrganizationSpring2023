.global main
.extern print_string
.type main function
.type print_string function

.text

main:
    push %rbp
    mov %rsp, %rbp
    sub $16, %rsp
    movl $1, -4(%rbp)
    movl $8, -8(%rbp)
    movl $3, -12(%rbp)
    leaq -12(%rbp), %rdi
    sub $16, %rsp
    movl $1, -16(%rbp)
    movl $8, -20(%rbp)
    movl $5, -24(%rbp)
    leaq -24(%rbp), %rsi
    mov $3, %rdx
    call equalArrays
    cmp $1, %rax
    jne main_not_equals

main_equals:
    leaq msg_equals(%rip), %rdi
    call print_string
    jmp main_done

main_not_equals:
    leaq msg_not_equals(%rip), %rdi
    call print_string

main_done:
    add $32, %rsp
    mov $0, %rax
    leave
    ret




.data
msg_equals: .asciz "Arrays are equal\n"
msg_not_equals: .asciz "Arrays are not equal\n"
