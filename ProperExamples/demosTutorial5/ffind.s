/*
    Finds a string in a file, returning the index of the first character of the string.
*/

.global main
.type main function
.extern print_string
.extern print_integer
.extern equals
.extern strlength
.extern file_open
.extern file_read
.extern file_seek
.extern errno
.type print_string function
.type print_integer function
.type equals function
.type strlength function
.type file_open function
.type file_read function
.type file_seek function
.type errno function

main:
    push %rbp
    mov %rsp, %rbp
    push %rdi   # saves argc as a local variable at -8(%rbp)
    push %rsi   # saves argv as a local variable at -16(%rbp)
    sub $56, %rsp   /* 
                        save space for:
                            - the file descriptor (-24);
                            - the string to search (-32);
                            - the string's size (-40)
                            - the current offset (-48)
                            - if the string was found (-56)
                            - the address of the local buffer (-64)
                            - read bytes (-72)
                    */
    cmpq $3, -8(%rbp)
    je main_find_in_file_init
    jmp main_wrong_amount_of_arguments

main_find_in_file_init:
    movq $-1, -48(%rbp)     # save current offset as minus one (we will use a do-while loop)
    movq $0, -56(%rbp)      # save the found flag, starting with false
    movq -16(%rbp), %r8     # argv
    mov 16(%r8), %r9        # argv[2] is the string to search
    mov 8(%r8), %r10
    movq %r9, -32(%rbp)
    mov %r9, %rdi
    call strlength
    movq %rax, -40(%rbp)
    cmpq $0, -40(%rbp)
    jz main_print_offset
    sub %rax, %rsp          # create local array of chars with the size of the string
    sub $1, %rsp            # add one more byte for the final NULL character
    movq %rsp, -64(%rbp)    # save the address of the local array
    mov %r10, %rdi          # argv[1] is the file where to search
    mov $0, %rsi
    call file_open
    movq %rax, -24(%rbp)
    cmpq $0, -24(%rbp)
    jge main_find_in_file_loop_body

main_error_opening_file:
    leaq messages_error_file_open(%rip), %rdi
    call print_string
    movq -24(%rbp), %rdi
    call errno
    mov %rax, %rdi
    mov $1, %rsi
    call print_integer
    mov $2, %al
    jmp main_exit

main_find_in_file_loop_body:
    incq -48(%rbp)
    movq -24(%rbp), %rdi
    movq -48(%rbp), %rsi
    mov $0, %rdx
    call file_seek
    movq %rax, -72(%rbp)
    cmpq $0, -72(%rbp)
    jl main_file_seek_failed
    movq -24(%rbp), %rdi
    movq -64(%rbp), %rsi
    movq -40(%rbp), %rdx
    call file_read
    movq %rax, -72(%rbp)
    cmpq $0, -72(%rbp)
    jl main_error_reading_from_file
    movq -40(%rbp), %r15
    cmpq %r15, -72(%rbp)
    jl main_print_offset
    movq -32(%rbp), %rdi
    movq -64(%rbp), %rsi
    call equals
    movq %rax, -56(%rbp)

main_find_in_file_loop_test:
    cmpq $0, -56(%rbp)
    jz main_find_in_file_loop_body
    jmp main_print_offset

main_file_seek_failed:
    leaq messages_error_file_seek(%rip), %rdi
    call print_string
    movq -72(%rbp), %rdi
    call errno
    mov %rax, %rdi
    mov $1, %rsi
    call print_integer
    mov $4, %al
    jmp main_exit

main_wrong_amount_of_arguments:
    leaq messages_error_argssize(%rip), %rdi
    call print_string
    mov $1, %al
    jmp main_exit

main_error_reading_from_file:
    leaq messages_error_file_read(%rip), %rdi
    call print_string
    movq -72(%rbp), %rdi
    call errno
    mov %rax, %rdi
    mov $1, %rsi
    call print_integer
    mov $3, %al
    jmp main_exit

main_print_offset:
    leaq messages_result(%rip), %rdi
    call print_string
    mov $-1, %rdi
    cmpq $0, -56(%rbp)
    cmovnz -48(%rbp), %rdi
    mov $1, %rsi
    call print_integer

main_exit:
    movq -40(%rbp), %r8  # -----
    add $1, %r8         # clean the local array
    add %r8, %rsp       # -----
    add $72, %rsp
    leave
    ret


messages_error_argssize: .asciz "Wrong amount of arguments\nTwo arguments must be provided\n->A path to a file, and a string to search\n"
messages_error_file_open: .asciz "Error opening file, errno: "
messages_error_file_read: .asciz "Error reading file, errno: "
messages_error_file_seek: .asciz "Error setting file's offset, errno: "
messages_result: .asciz "Offset of searched string in file: "
newline: .asciz "\n"

