/*
    Compares two local strings.
*/

.global main
.type main function
.extern print_string
.extern equals
.type print_string function
.type equals function

main:
    push %rbp
    mov %rsp, %rbp
    leaq messages_comparing_init(%rip), %rdi
    call print_string
    leaq testStringA(%rip), %rdi
    push %rdi
    call print_string
    leaq messages_comparing_with(%rip), %rdi
    call print_string
    leaq testStringE(%rip), %rdi
    push %rdi
    call print_string
    leaq newline(%rip), %rdi
    call print_string
    leaq messages_comparing_result_init(%rip), %rdi
    call print_string
    pop %rsi
    pop %rdi
    call equals
    cmp $0, %rax
    jz main_print_different

main_print_equals:
    leaq messages_comparing_result_equals(%rip), %rdi
    call print_string
    jmp main_exit

main_print_different:
    leaq messages_comparing_result_different(%rip), %rdi
    call print_string

main_exit:
    leave
    ret

.data
testStringA: .asciz "Hello"
testStringB: .asciz "He"
testStringC: .asciz ""
testStringD: .asciz "Hella"
testStringE: .asciz "Hello"
messages_comparing_init: .asciz "Comparing "
messages_comparing_with: .asciz " with "
messages_comparing_result_init: .asciz "Strings are "
messages_comparing_result_equals: .asciz "equals!\n"
messages_comparing_result_different: .asciz "different!\n"
newline: .asciz "\n"

