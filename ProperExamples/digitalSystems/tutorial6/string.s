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

/*
Prints a number as a string, it takes two arguments:
the number to print as the first argument
a boolean stating either a new line should be printed at the end or not
*/
print_integer:
  push %rbp
  mov %rsp, %rbp
  leaq digitSpace(%rip), %rcx
  cmp $0, %rsi
  jz print_integer_finish_init

print_integer_newline:
  movb $NEWLINE, (%rcx)
  
print_integer_finish_init:
  push %rdi # the number to print (%rbp - 8)
  push %rcx # the buffer to create the string representation (%rbp - 16)
  cmpq $0, -8(%rbp)
  jge print_integer_start
  negq -8(%rbp)
  mov $SYS_WRITE, %rax
  mov $STDOUT, %rdi
  leaq newline(%rip), %rsi
  mov $1, %rdx
  syscall

print_integer_start:
  mov -8(%rbp), %rax
  
/*
Internal implementation to print a number into ASCII
*/
integer_to_string:
  mov $0, %rdx
  mov $10, %rbx
  div %rbx
  add $48, %rdx
  
  incq -16(%rbp)
  mov -16(%rbp), %rcx
  mov %rdx, (%rcx)
  cmp $0, %rax
  jne integer_to_string

print_characters:
  mov $SYS_WRITE, %rax
  mov $STDOUT, %rdi
  mov -16(%rbp), %rsi
  mov $1, %rdx
  syscall
  
  decq -16(%rbp)
  mov -16(%rbp), %rcx
  
  leaq digitSpace(%rip), %r8
  cmp %r8, %rcx
  jge print_characters
  # Clear the two saved local variables
  addq $16, %rsp # this is the equivalent of two pops discarding the popped value
                 # function _printNumberFromString does not call this function,
                 # so the responsibility of cleaning the stack of local variables which
                 # belong to _printNumberFromString is still part of this implementation 
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
newline: .ascii "-"

.bss
digitSpace: .space 100
