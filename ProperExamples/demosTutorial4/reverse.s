.global main
.type main function
.extern _exit

.text

main:
    push %rbp
    mov %rsp, %rbp
    cmp $1, %rdi
    jng wrongArguments
    mov %rsi, %r8
    mov %rdi, %rsi
    mov %r8, %rdi
    leaq 8(%rdi), %rdi # skip first element
    decq %rsi
    call printArgumentsInReverse    # it takes an array and it's size
    mov $0, %rdi
    call _exit

wrongArguments:
    push %rdi
    leaq msgwrongnargs(%rip), %rdi
    call _print_string
    pop %rdi
    call _printNumberAsString
    leaq usage(%rip), %rdi
    call _print_string
    leaq endofline(%rip), %rdi
    call _print_string
    mov $1, %rdi
    call _exit

printArgumentsInReverse:
    push %rbp
    mov %rsp, %rbp
    push %rdi   # argv (-8)
    push %rsi   # argc (-16)
    mov %rsi, %r8
    imul $8, %r8
    sub $8, %r8
    push %r8     # offset (-24)
    jmp printArgumentsTest

printArgumentsLoop:
    mov -8(%rbp), %rdi
    mov -24(%rbp), %r8
    mov (%rdi, %r8), %rdi
    call _print_string
    subq $8, -24(%rbp)
    decq -16(%rbp)
    mov -16(%rbp), %r8
    cmp $0, %r8
    jz printArgumentsTest
    leaq space(%rip), %rdi
    call _print_string

printArgumentsTest:
    mov -16(%rbp), %r8
    cmp $0, %r8
    jnz printArgumentsLoop
    leaq endofline(%rip), %rdi
    call _print_string
    mov $0, %rax
    leave
    ret

.data
space: .asciz " "
endofline: .asciz "\n"
msgwrongnargs: .asciz "Wrong number of arguments: "
usage: .asciz "Usage: ./reverse <strings>"
