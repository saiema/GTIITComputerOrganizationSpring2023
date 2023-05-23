.global main
.type main function
.extern print_string
.extern print_integer
.type print_string function
.type print_integer function

.text

main:
    push %rbp
    mov %rsp, %rbp
    # TODO: define an array of N numbers
    # TODO: define a variable size of the array
    # TODO: call printFiltered with the array, the size, and a 1 or 0 depending on
    #       whether to print even numbers or odd numbers.
    # TODO: restore the stack pointer so the saved rbp is at the top of the stack
    leave
    ret

/*
    This function takes an array numbers, the size, and a value (1 or 0) that
    determines whether to print even or odd numbers.
    It will print all numbers in the array that matches the filtering criteria
*/
printFiltered:
    push %rbp
    mov %rsp, %rbp
    push %rdi
    push %rsi
    push %rdx
    push $0
    jmp printFiltered_loop_test

printFiltered_loop_body:
    mov -8(%rbp), %r8
    mov -32(%rbp), %r9
    incq -32(%rbp)
    # TODO: complete getting the element at array[i] into rdi
    mov -24(%rbp), %rsi
    call shouldFilter
    cmp $1, %rax
    jnz printFiltered_loop_test
    # TODO: complete getting the element at array[i] into rdi
    mov $0, %rsi
    call print_integer
    mov $space, %rdi
    call print_string


printFiltered_loop_test:
    mov -32(%rbp), %r8
    mov -16(%rbp), %r9
    cmp %r8, %r9
    jnz printFiltered_loop_body

printFiltered_done:
    add $32, %rsp
    mov $newline, %rdi
    call print_string
    mov $0, %rax
    leave
    ret

/*
    This function takes two arguments, a number and a boolean
    if the boolean is true, the function will return true iff the number is even
    if the boolean is false, the function will return true iff the number is odd 
*/
shouldFilter:
    push %rbp
    mov %rsp, %rbp
    push %rdi
    push %rsi
    # TODO: complete
    add $8, %rsp
    leave
    ret

.data
space: .asciz " "
newline: .asciz "\n"