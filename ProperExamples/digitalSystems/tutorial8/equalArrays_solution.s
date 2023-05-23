equalArrays:
    push %rbp
    mov %rsp, %rbp
    push %rsi # 8   (first array)
    push %rdi  # 16 (second array)
    push %rdx  # 24 (size)
    push $0    # 32 (index)
    cmpq $0, -24(%rbp)
    jz equalArrays_equal
    jmp equalArrays_loop_test

equalArrays_loop_body:
    mov -8(%rbp), %r8
    mov -32(%rbp), %r9
    mov (%r8, %r9, 4), %r10d
    mov -16(%rbp), %r8
    mov (%r8, %r9, 4), %r11d
    cmp %r10d, %r11d
    jne equalArrays_not_equals
    incq -32(%rbp)

equalArrays_loop_test:
    mov -32(%rbp), %r8
    mov -24(%rbp), %r9
    cmp %r8, %r9
    jg equalArrays_loop_body

equalArrays_equal:
    mov $1, %rax
    jmp equalArrays_done

equalArrays_not_equals:
    mov $0, %rax

equalArrays_done:
    add $32, %rsp
    leave
    ret