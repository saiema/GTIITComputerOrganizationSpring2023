.global filterBooksByAuthor
.global countFilteredBooksByAuthor
.type filterBooksByAuthor function
.type countFilteredBooksByAuthor function

.text


countFilteredBooksByAuthor:
    push %rbp
    mov %rsp, %rbp
    mov %rsi, %rax
    leave
    ret

filterBooksByAuthor:
    push %rbp
    mov %rsp, %rbp
    mov %rdi, %rax
    leave
    ret

    /*push %rdi           # the array of books    (8)
    push %rsi           # the size of the array (16)
    push %rdx           # the author to filter  (24)
    push $0             # index                 (32)
    push $0             # count                 (40)
    jmp countFilteredBooksByAuthor_loop_test

countFilteredBooksByAuthor_loop_body:
    mov -8(%rbp), %r8
    mov -32(%rbp), %r9
    

countFilteredBooksByAuthor_loop_test:
    mov -40(%rbp), %r8
    mov -16(%rbp), %r9
    cmp %r8, %r9
    jg countFilteredBooksByAuthor_loop_body

countFilteredBooksByAuthor_done:
    mov -40(%rbp), %rax
    add $40, %rsp
    leave
    ret

*/
