.global _printNumberAsString
.global _print_n_bytes
.global _print_string
.global _exit
.type _printNumberAsString function
.type _print_n_bytes function
.type _print_string function
.type _exit function

.text

.equ SYS_WRITE, 1
.equ SYS_EXIT, 60
.equ STDOUT, 1
.equ NEWLINE, 10

/*
Prints a number as a string, it takes only one argument
The argument is expected to be in rdi register.
*/
_printNumberAsString:
  mov $digitSpace, %rcx
  movb $NEWLINE, (%rcx)
  push %rdi #saves rdi since the register will be modified
  push %rcx
  mov %rdi, %rax
  
/*
Internal implementation to print a number into ASCII
*/
_printRAXLoop:
  mov $0, %rdx
  mov $10, %rbx
  div %rbx
  add $48, %rdx
  
  incq (%rsp)
  mov (%rsp), %rcx
  mov %rdx, (%rcx)
  cmp $0, %rax
  jne _printRAXLoop

_printRAXLoop2:
  mov $SYS_WRITE, %rax
  mov $STDOUT, %rdi
  mov (%rsp), %rsi
  mov $1, %rdx
  syscall
  
  decq (%rsp)
  mov (%rsp), %rcx
  
  cmp $digitSpace, %rcx
  jge _printRAXLoop2
  # Clear the two saved local variables
  addq $16, %rsp # this is the equivalent of two pops discarding the popped value
                 # function _printNumberFromString does not call this function,
                 # so the responsibility of cleaning the stack of local variables which
                 # belong to _printNumberFromString is still part of this implementation 
  ret
  

/*
Print a null-terminate string, this subroutine expects only one argument:
the address where the string begins, this address is expected to be in
register rdi.
*/
_print_string:
  push %rdi #we need to save the original string address
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
	ret


/*
Prints a string to standard output, expected two arguments
using registers rdi and rsi.
The first argument is the address where the string starts
The second argument is how many bytes to print
*/
_print_n_bytes:
  push %rdi # save the string pointer
  push %rsi # save the size to write
  mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi 
	pop %rdx # fill the size to write argument
	pop %rsi # fill the string pointer to write
	syscall
	ret
	
/*
Call exit with an exit code stored in register rdi
*/
_exit:
  mov $SYS_EXIT, %rax
	syscall
	
.bss
digitSpace: .space 100
