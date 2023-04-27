.global main
.type main function

.text

.equ SYS_WRITE, 1
.equ STDOUT, 1

main:
    push %rbp
    mov %rsp, %rbp
    mov $478, %rdi
    call integerToString
    leave
    ret


/*Function that takes an integer number and returns it's string representation*/
integerToString:
    push %rbp
    mov %rsp, %rbp
    push %rdi       # number -8(%rbp)
    push $0         # isNegative -16(%rbp)
    push $-1        # counter -24(%rbp)
    push $1         # segments -32(%rbp)
    sub $8, %rsp    # first 8 bits to save the string
    cmp $0, %rdi
    jge integerToString_convert
    negq -8(%rbp)
    movq $1, -16(%rbp)

integerToString_convert:
    mov -8(%rbp), %rax
    mov $0, %rdx
    mov $10, %rbx
    div %rbx
    add $48, %rdx
    mov %rax, -8(%rbp)

    leaq -32(%rbp), %r8
    mov -24(%rbp), %r9
    leaq (%r8, %r9, 1), %r10
    mov %dl, (%r10)
    decb -24(%rbp)

    cmp $0, %rax
    jz integerToString_print_negative
    mov -24(%rbp), %rax
    neg %rax
    mov $0, %rdx
    mov $8, %rbx
    div %rbx

    inc %rax
    mov -32(%rbp), %r8
    cmp %r8, %rax
    jle integerToString_convert
    sub $8, %rsp
    incq -32(%rbp)
    jmp integerToString_convert

integerToString_print_negative:
    cmpq $0, -16(%rbp)
    jz integerToString_print_number
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov $negativeSymbol, %rsi
    mov $1, %rdx
    syscall

integerToString_print_number:
    leaq -32(%rbp), %r8
    mov -24(%rbp), %r9
    leaq (%r8, %r9, 1), %r10
    neg %r9
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov %r10, %rsi
    mov %r9, %rdx
    syscall

integerToString_print_newLine:
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov $newLineSymbol, %rsi
    mov $1, %rdx
    syscall

integerToString_print_exit:
    mov -32(%rbp), %r8
    leaq (%rsp, %r8, 8), %rsp
    add $32, %rsp
    mov $0, %rax
    leave
    ret


.data
negativeSymbol: .ascii "-"
newLineSymbol: .ascii "\n"
