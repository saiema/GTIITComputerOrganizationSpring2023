.global main
.type main function

.text

main:
    push %rbp
    mov %rsp, %rbp

    sub $8, %rsp
               
    movb $4, -1(%rbp)    # -1(%rbp)        
    movb $10, -2(%rbp)   # -2(%rbp) 
    movb $8, -3(%rbp)    # -3(%rbp)
    movb $3, -4(%rbp)    # -4(%rbp)
    movb $5, -5(%rbp)    # -5(%rbp)
    movb $9, -6(%rbp)    # -6(%rbp)
    movb $16, -7(%rbp)   # -7(%rbp)
    movb $2, -8(%rbp)    # -8(%rbp)

    
    leaq -8(%rbp), %rdi  # The array starts at the address rbp - 8, this address is pointing to
    mov $8, %rsi         # the byte that has a zero
    call maximum
    add $8, %rsp

    leave

    ret

/*
A function that takes two arguments: an array and a size
And returns the maximum value on the array
*/
maximum:
                         #                  /------------------------\ <----- rsp
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------| <----- rdi
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| <----- rbp
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------|
                         #                  |       ret address      | {8 bytes}
    push %rbp
    mov %rsp, %rbp
                         #                  /------------------------\ <----- rsp, rbp
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------|
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------| <----- rdi
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------|
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------|
                         #                  |       ret address      | {8 bytes}
    push %rdi       # the array at -8(%rbp)
    push %rsi       # the size at -16(%rbp)
    push $-1        # current maximum at -24(%rbp)
    push $0         # index i at -32(%rbp)
                         #                  /------------------------\ <----- rsp, rbp - 32
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| <----- rbp - 24
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| <----- rbp - 16
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| <----- rbp - 8
                         #                  |          rdi           | {8 bytes}
                         #                  |------------------------| <----- rbp
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| 
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------| <----- rdi
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| 
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}
    jmp maximum_loop_test

maximum_loop_body:
    mov -8(%rbp), %r8   # array
    mov -32(%rbp), %r9  # index i
    movsbq (%r8, %r9, 1), %rdi # array[i] (considering elements of 1 byte)
    mov -24(%rbp), %rsi # the current maximum
    call max
    mov %rax, -24(%rbp)
    incq -32(%rbp)  # i ++

maximum_loop_test:
    mov -32(%rbp), %r8  # index i
    mov -16(%rbp), %r9  # size
    cmp %r8, %r9
    jnz maximum_loop_body

maximum_loop_return:
    mov -24(%rbp), %rax
    add $32, %rsp
                         #                  /------------------------\ 
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| 
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| 
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| 
                         #                  |          rdi           | {8 bytes}
                         #                  |------------------------| <----- rsp, rbp
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| 
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------| <----- rdi
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| 
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}
    leave
                         #                  rbp is restored (pop %rbp)
                         #                  /------------------------\ 
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| 
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| 
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| 
                         #                  |          rdi           | {8 bytes}
                         #                  |------------------------|
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| <----- rsp
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------| <----- rdi
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| <----- rbp
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}
    ret

/*Function that takes two arguments and return the greater of those*/
max:
                         #                  /------------------------\ <----- rsp
                         #                  | ret address (line 115) | {8 bytes}
                         #                  |------------------------| <----- rbp - 32
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| <----- rbp - 24
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| <----- rbp - 16
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| <----- rbp - 8
                         #                  |      array address     | {8 bytes}
                         #                  |------------------------| <----- rbp
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| 
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------|
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| 
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}
    push %rbp
    mov %rsp, %rbp
                         #                  /------------------------\ <----- rsp, rbp
                         #                  |     rbp(from maximum)  | {8 bytes}
                         #                  |------------------------| 
                         #                  | ret address (line 115) | {8 bytes}
                         #                  |------------------------| 
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| 
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| 
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| 
                         #                  |      array address     | {8 bytes}
                         #                  |------------------------| 
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| 
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------|
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| 
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}       
    mov %rdi, %rax
    cmp %rdi, %rsi      # rsi - rdi
    cmovg %rsi, %rax    # if rsi > rdi then rax <- rsi
    leave
                         #                  rbp is restored (pop %rbp)
                         #                  /------------------------\
                         #                  |     rbp(from maximum)  | {8 bytes}
                         #                  |------------------------| <----- rsp
                         #                  | ret address (line 139) | {8 bytes}
                         #                  |------------------------| <----- rbp - 32
                         #                  |       index i (0)      | {8 bytes}
                         #                  |------------------------| <----- rbp - 24
                         #                  |  current maximum (-1)  | {8 bytes}
                         #                  |------------------------| <----- rbp - 16
                         #                  |          rsi (8)       | {8 bytes}
                         #                  |------------------------| <----- rbp - 8
                         #                  |      array address     | {8 bytes}
                         #                  |------------------------| <----- rbp
                         #                  |      rbp(from main)    | {8 bytes}
                         #                  |------------------------| 
                         #                  |  ret address (line 43) | {8 bytes}
                         #                  |------------------------|
                         #                  |2, 16, 9, 5, 3, 8, 10, 4| {8 bytes}
                         #                  |------------------------| 
                         #                  |           rbp          | {8 bytes}
                         #                  |------------------------| 
                         #                  |       ret address      | {8 bytes}
    ret    
