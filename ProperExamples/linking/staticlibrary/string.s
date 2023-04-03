.global _print_integer
.global _print_string
.type _print_integer function
.type _print_string function

.text

.equ SYS_WRITE, 1
.equ STDOUT, 1
.equ NEWLINE, 10

/*
Prints a number as a string, it takes two arguments:
the number to print as the first argument
a boolean stating either a new line should be printed at the end or not
*/
_print_integer:
  push %rbp
  mov %rsp, %rbp
  leaq digitSpace(%rip), %rcx
  cmp $0, %rsi
  jz _print_integer_finish_init

_print_integer_no_newline:
  movb $NEWLINE, (%rcx)
  
_print_integer_finish_init:
  push %rdi # the number to print (%rbp - 8)
  push %rcx # the buffer to create the string representation (%rbp -16)
  mov %rdi, %rax
  
/*
Internal implementation to print a number into ASCII
*/
_integer_to_string:
  mov $0, %rdx
  mov $10, %rbx
  div %rbx
  add $48, %rdx
  
  incq -16(%rbp)
  mov -16(%rbp), %rcx
  mov %rdx, (%rcx)
  cmp $0, %rax
  jne _integer_to_string

_print_characters:
  mov $SYS_WRITE, %rax
  mov $STDOUT, %rdi
  mov -16(%rbp), %rsi
  mov $1, %rdx
  syscall
  
  movb $0, -16(%rbp)
  decq -16(%rbp)
  mov -16(%rbp), %rcx
  
  leaq digitSpace(%rip), %r8
  cmp %r8, %rcx
  jge _print_characters
  # Clear the two saved local variables
  addq $16, %rsp # this is the equivalent of two pops discarding the popped value
                 # function _printNumberFromString does not call this function,
                 # so the responsibility of cleaning the stack of local variables which
                 # belong to _printNumberFromString is still part of this implementation 
  leave
  ret
  

/*
Print a null-terminate string, this subroutine expects only one argument:
the address where the string begins, this address is expected to be in
register rdi.
*/
_print_string:
  push %rbp
  mov %rsp, %rbp
  push %rdi # string to print (%rbp - 8)
  mov %rdi, %rax
  mov $0, %rbx
_printLoop:
  mov (%rax), %cl # We use cl, because string characters in ASCII are one byte long
	cmp $0, %cl
	je _endPrintLoop
	inc %rbx
	inc %rax
	jmp _printLoop
_endPrintLoop:
	mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi
	pop %rsi
	mov %rbx, %rdx
	syscall
	leave
	ret
	
.bss
digitSpace: .space 100
