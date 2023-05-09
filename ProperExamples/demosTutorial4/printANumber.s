.global main
.type main function
.extern _printNumberAsString
.type _printNumberAsString function

.text

main:
    push %rbp
    mov %rsp, %rbp
    mov $32, %rdi
    mov $0, %rsi
    call _printNumberAsString
    leave
    ret
