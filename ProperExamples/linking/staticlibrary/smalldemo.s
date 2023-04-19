.global main
.type main function

.text

main:
    push %rbp
    mov %rsp, %rbp
    leaq string(%rip), %rdi
    call puts
    mov $0, %rax
    leave
    ret

.data
string: .asciz "Hello world\n"
