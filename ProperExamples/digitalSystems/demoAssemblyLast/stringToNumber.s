.global main
.type main function
.extern print_integer
.type print_integer function
.extern print_string
.type print_string function

.text

main:
    push %rbp
    mov %rsp, %rbp
    push %rdi       # argc at -8(%rbp)
    push %rsi       # argv at -16(%rbp)
    cmp $2, %rdi
    jne main_wrong_arguments

main_transform_and_print:
    mov -16(%rbp), %r8
    mov $1, %r9
    mov (%r8, %r9, 8), %rdi # argv[1]
    call stringToNumber
    mov %rax, %rdi
    mov $1, %rsi
    call print_integer
    jmp main_done

main_wrong_arguments:
    leaq wrongarguments(%rip), %rdi
    call print_string
    mov $1, %rax
    jmp main_done

main_done:
    mov $0, %rax
    add $16, %rsp
    leave
    ret

stringToNumber:
    push %rbp
    mov %rsp, %rbp
    push %rdi   # the string to convert at -8(%rbp)
    push $1     # multiplier variable at -16(%rbp)
    sub $8, %rsp # reserved space for our string's length at -24(%rbp)
    sub $8, %rsp # reserved space for our index variable at -32(%rbp)
    push $0      # our resulting number at -40(%rbp)
    call stringLength
    mov %rax, -24(%rbp)
    dec %rax
    mov %rax, -32(%rbp) # we are starting our index with size - 1
    jmp stringToNumber_loop_test

stringToNumber_loop_body:
    mov -8(%rbp), %r8
    mov -32(%rbp), %r9
    movzbq (%r8, %r9, 1), %rcx  # string[index]
    sub $48, %rcx               # we substract 48 from our digit to get the actual number
    mov -16(%rbp), %r10         # our multiplier
    mov -40(%rbp), %r11         # our current number
    imul %r10, %rcx             # current digit*multiplier
    add %rcx, %r11              # current number + (digit*multiplier)
    mov %r11, -40(%rbp)         # current number = current number + (digit*multiplier)
    imul $10, %r10              # multiplier * 10
    mov %r10, -16(%rbp)         # multiplier = multiplier * 10
    decq -32(%rbp)              # index--

stringToNumber_loop_test:
    cmpq $0, -32(%rbp)
    jge stringToNumber_loop_body    # we want to see all digits from index size - 1 to 0
                                    # so the condition is (index >= 0)

stringToNumber_done:
    mov -40(%rbp), %rax
    sub $40, %rsp
    leave
    ret

/*
Calculates the length of a null-terminated string
*/
stringLength:
    push %rbp
    mov %rsp, %rbp
    push %rdi    # the string to calculate it's length
    mov $0, %rax # our index, also length counter
    jmp stringLength_loop_test

stringLength_loop_body:
    inc %rax

stringLength_loop_test:
    mov -8(%rbp), %r8
    mov (%r8, %rax, 1), %cl # current character at string[index]
    cmp $0, %cl
    jnz stringLength_loop_body

stringLength_done:
    add $8, %rsp
    leave
    ret

.data
wrongarguments: .asciz "Wrong amount of arguments\nUsage is ./stringToNumber <number>\n"

