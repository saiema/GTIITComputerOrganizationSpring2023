.global main
.type main function

.text

.equ SYS_WRITE, 1
.equ STDOUT, 1

main:
    # draw stack here
    push %rbp
    mov %rsp, %rbp
    # draw stack here
    push %rdi
    push %rsi
    push $0
    # draw stack here
    jmp printArguments_test

printArguments_loop:
    mov -16(%rbp), %r8
    mov -24(%rbp), %r9
    mov (%r8, %r9, 8), %rdi
    call strlength
    # draw stack here

    mov %rax, %rdx
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov -16(%rbp), %r8
    mov -24(%rbp), %r9
    mov (%r8, %r9, 8), %rsi
    syscall

    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov $newline, %rsi
    mov $1, %rdx
    syscall

    incq -24(%rbp)


printArguments_test:
    mov -8(%rbp), %r8
    mov -24(%rbp), %r9
    cmp %r8, %r9
    jnz printArguments_loop

printArguments_done:
    add $24, %rsp
    # draw stack here
    mov $0, %rax
    leave
    # draw stack here
    ret

/*A function that takes a NULL-terminated string and returns its length*/
strlength:
    # draw stack here
    push %rbp
    mov %rsp, %rbp
    # draw stack here
    push %rdi
    # draw stack here
    mov $0, %rax
    jmp strlength_loop_test

strlength_loop_body:
    inc %rax

strlength_loop_test:
    mov -8(%rbp), %r8
    mov (%r8, %rax, 1), %cl
    cmp $0, %cl
    jnz strlength_loop_body

strlength_done:
    add $8, %rsp
    # draw stack here
    leave
    # draw stack here
    ret

.data
newline: .ascii "\n"
