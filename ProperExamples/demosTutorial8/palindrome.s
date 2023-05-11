.global main
.extern print_string
.extern strlength
.type main function
.type print_string function
.type strlength function

.text

main:
    push %rbp
    mov %rsp, %rbp
    cmp $2, %rdi
    jne main_wrongarguments
    sub $16, %rsp
    mov $1, %r9
    mov (%rsi, %r9, 8), %r10
    mov %r10, -8(%rbp)
    mov -8(%rbp), %rdi
    call isPalindrome
    mov %rax, -16(%rbp)
    leaq msg_main_palindrome_prologue(%rip), %rdi
    call print_string
    mov -8(%rbp), %rdi
    call print_string
    cmpq $1, -16(%rbp)
    jne main_isNotPalindrome

main_isPalindrome:
    leaq msg_main_palindrome_isPalindrome(%rip), %rdi
    call print_string
    mov $0, %rax
    jmp main_done    

main_isNotPalindrome:
    leaq msg_main_palindrome_isNotPalindrome(%rip), %rdi
    call print_string
    mov $0, %rax
    jmp main_done

main_wrongarguments:
    leaq msg_main_wrongarguments(%rip), %rdi
    call print_string
    mov $1, %rax

main_done:
    add $16, %rsp
    leave
    ret

isPalindrome:
    push %rbp
    mov %rsp, %rbp
    push %rdi
    call strlength
    push %rax
    push $0
    jmp isPalindrome_loop_test

isPalindrome_loop_body:
    mov -16(%rbp), %r10
    dec %r10
    sub -24(%rbp), %r10
    push %r10
    mov -8(%rbp), %r8
    mov -24(%rbp), %r9
    mov (%r8, %r9, 1), %cl
    mov -32(%rbp), %r9
    mov (%r8, %r9, 1), %dl
    cmp %cl, %dl
    jne isPalindrome_isNotPalindrome
    incq -24(%rbp)
    add $8, %rsp

isPalindrome_loop_test:
    mov -24(%rbp), %r8
    mov -16(%rbp), %r9
    cmp %r8, %r9
    jg isPalindrome_loop_body 

isPalindrome_isPalindrome:
    mov $1, %rax
    jmp isPalindrome_done

isPalindrome_isNotPalindrome:
    mov $0, %rax

isPalindrome_done:
    add $24, %rsp
    leave
    ret


.data

msg_main_wrongarguments: .asciz "Wrong arguments\nUsage: ./palindrome <string>\n"
msg_main_palindrome_prologue: .asciz "The string "
msg_main_palindrome_isPalindrome: .asciz " is a palindrome\n"
msg_main_palindrome_isNotPalindrome: .asciz " is not a palindrome\n"
