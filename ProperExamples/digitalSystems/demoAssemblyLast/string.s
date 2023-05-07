.global print_integer
.global print_string
.global equals
.global strlength
.type print_integer function
.type print_string function
.type equals function
.type strlength function

.text

.equ SYS_WRITE, 1
.equ STDOUT, 1
.equ NEWLINE, 10

/*Function that takes an integer number and returns it's string representation*/
print_integer:
    push %rbp
    mov %rsp, %rbp
    push %rdi       # number -8(%rbp)
    push $0         # isNegative -16(%rbp)
    push $-1        # counter -24(%rbp)
    push $1         # segments -32(%rbp)
    sub $8, %rsp    # first 8 bits to save the string
    cmp $0, %rdi
    jge print_integer_convert
    negq -8(%rbp)
    movq $1, -16(%rbp)

print_integer_convert:
    mov -8(%rbp), %rax
    mov $0, %rdx
    mov $10, %rbx
    div %rbx
    add $48, %rdx
    mov %rax, -8(%rbp)

    leaq -32(%rbp), %r8
    mov -24(%rbp), %r9
    leaq (%r8, %r9, 1), %r10
    mov %dl, (%r10)
    decb -24(%rbp)

    cmp $0, %rax
    jz print_integer_print_negative
    mov -24(%rbp), %rax
    neg %rax
    mov $0, %rdx
    mov $8, %rbx
    div %rbx

    inc %rax
    mov -32(%rbp), %r8
    cmp %r8, %rax
    jle print_integer_convert
    sub $8, %rsp
    incq -32(%rbp)
    jmp print_integer_convert

print_integer_print_negative:
    cmpq $0, -16(%rbp)
    jz print_integer_print_number
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    leaq negativeSymbol(%rip), %rsi
    mov $1, %rdx
    syscall

print_integer_print_number:
    leaq -32(%rbp), %r8
    mov -24(%rbp), %r9
    leaq (%r8, %r9, 1), %r10
    neg %r9
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    mov %r10, %rsi
    mov %r9, %rdx
    syscall

print_integer_print_newLine:
    mov $SYS_WRITE, %rax
    mov $STDOUT, %rdi
    leaq newLineSymbol(%rip), %rsi
    mov $1, %rdx
    syscall

print_integer_print_exit:
    mov -32(%rbp), %r8
    leaq (%rsp, %r8, 8), %rsp
    add $32, %rsp
    mov $0, %rax
    leave
    ret
  

/*
Print a null-terminate string, this subroutine expects only one argument:
the address where the string begins
*/
print_string:
  push %rbp
  mov %rsp, %rbp
  push %rdi # string to print (%rbp - 8)
  mov %rdi, %rax
  mov $0, %rbx
printLoop:
  mov (%rax), %cl # We use cl, because string characters in ASCII are one byte long
	cmp $0, %cl
	je endPrintLoop
	inc %rbx
	inc %rax
	jmp printLoop
endPrintLoop:
	mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi
	pop %rsi
	mov %rbx, %rdx
  syscall
	leave
	ret

/*Compare two NULL-terminated strings*/
equals:
  push %rbp
  mov %rsp, %rbp
  push %rdi     # first string (a) at -8(%rbp)
  push %rsi     # second string (b) at -16(%rbp)
  push $0       # index i at -24(%rbp)
  xor %rax, %rax  # set %rax at all zeros (just in case)
  mov $1, %al     # equals flag
  jmp equals_loop_condition

equals_loop_body:
  mov -8(%rbp), %r8   # starting address of string a
  mov -24(%rbp), %r10
  mov (%r8, %r10), %cl  # character at a[i]
  mov -16(%rbp), %r9    # starting address of string b
  mov (%r9, %r10), %dl  # character at b[i]
  cmp %cl, %dl
  sete %al              # equals = a[i] == b[i]
  cmp $0, %cl
  sete %r8b             # a[i] == 0
  and %al, %r8b         # equals && a[i] == 0
  jnz equals_done
  incq -24(%rbp)

equals_loop_condition:
  cmp $0, %rax        # equals flag (compare if it's not zero)
  jnz equals_loop_body

equals_done:
	addq $32, %rsp  # remove/clean local variables
  leave
  ret

/*Given a NULL-terminated string, this function will return the size of that string*/
strlength:
  push %rbp
  mov %rsp, %rbp
  push %rdi       # string at -8(%rbp)
  mov $0, %rax
  jmp strlength_loop_test

strlength_loop_body:
  inc %rax

strlength_loop_test:
  mov -8(%rbp), %r8
  mov (%r8, %rax), %cl
  cmp $0, %cl
  jnz strlength_loop_body

strlength_return:
  sub $8, %rsp
  leave
  ret

.data
negativeSymbol: .ascii "-"
newLineSymbol: .ascii "\n"

