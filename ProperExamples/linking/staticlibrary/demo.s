.global main
.type main function
.extern _print_integer
.extern _print_string
.type _print_integer function
.type _print_string function
.extern _exit
.type _exit function

main:
    push %rbp
    mov %rsp, %rbp
    push %rdi # argc (%rbp - 8)
    push %rsi # argv (%rbp - 16)
    push $0   # index (i) (%rbp - 24)
    leaq nargsmsg(%rip), %rdi
    call _print_string
    mov -8(%rbp), %rdi
    mov $1, %rsi
    call _print_integer
    leaq newline(%rip), %rdi
    call _print_string
    jmp printArguments_test

printArguments:
    leaq argmsg_init(%rip), %rdi
    call _print_string
    mov -24(%rbp), %rdi
    mov $0, %rsi
    call _print_integer
    leaq argmsg_end(%rip), %rdi
    call _print_string
    mov -16(%rbp), %r8      # argv
    mov -24(%rbp), %r9      # i
    mov %r9, %rdi
    mov (%r8, %r9, 8), %rdi # argv[i]
    call _print_string
    leaq newline(%rip), %rdi
    call _print_string
    incq -24(%rbp)          # i++


printArguments_test:
    mov -8(%rbp), %r8
    cmp %r8, -24(%rbp)
    jnz printArguments

done:
    mov $0, %rdi
    call _exit

.data
nargsmsg: .asciz "Number of arguments: "
newline: .asciz "\n"
argmsg_init: .asciz "Argument["
argmsg_end: .asciz "]: "
