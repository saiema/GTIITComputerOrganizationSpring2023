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

equalArrays:
    push %rbp
    mov %rsp, %rbp
    push %rdi # arrayA at -8(%rbp)
    push %rsi # arrayB at -16(%rbp)
    push %rdx # size at -24(%rbp)
    push $0   # the index at -32(%rbp)
    jmp equalArrays_loop_test

equalArrays_loop_body:
    mov -8(%rbp), %r8
    mov -32(%rbp), %r9
    mov (%r8, %r9, 4), %r10d
    mov -16(%rbp), %r8
    mov (%r8, %r9, 4), %r11d
    cmp %r10d, %r11d
    jne equalArrays_notEquals
    incq -32(%rbp)

equalArrays_loop_test:
    mov -24(%rbp), %r8
    cmp -32(%rbp), %r8
    jg equalArrays_loop_body

equalArrays_equals:
    mov $1, %rax
    jmp equalArrays_done

equalArrays_notEquals:
    mov $0, %rax

equalArrays_done:
    add $32, %rsp
    leave
    ret

.data
msg_equals: .asciz "Arrays are equal\n"
msg_not_equals: .asciz "Arrays are not equal\n"
