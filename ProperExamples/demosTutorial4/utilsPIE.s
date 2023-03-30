.global _printNumberAsString
.global _print_n_bytes
.global _print_string
.global _check_flags
.global _power_n
.global _exit
.type _printNumberAsString function
.type _print_n_bytes function
.type _print_string function
.type _check_flags function
.type _power_n function
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
  push %rbp
  mov %rsp, %rbp
  leaq digitSpace(%rip), %rcx
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
  
  leaq digitSpace(%rip), %r8
  cmp %r8, %rcx
  # cmp $digitSpace, %rcx
  jge _printRAXLoop2
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
	leave
	ret

/*
Given a value and a set of flags, this function will check if
the value contains all flags.
The first argument, i.e.: the value, is expected in rdi.
The second argument, i.e.: the flags, is expected in rsi
The result will be either a 1 or a 0 stored in rax.
*/
_check_flags:
  push %rbp
  mov %rsp, %rbp
  and %rsi, %rdi
  test %rdi, %rsi
  setne %al
  movzbl %al, %eax
  leave
  ret
  
/*
Given two values, this function will return the first value
to the power of the second value.
The first argument (a) is expected in rdi
The second argument (b) is expected in rsi
The result (a^b) will be stored in rax
*/
_power_n:
  push %rbp
  mov %rsp, %rbp
  push %rdi #saves value a -8(%rbp)
  push %rsi #saves value b -16(%rbp)
  cmpq $0, -16(%rbp)
  je _power_n_one
  cmpq $0, -8(%rbp)
  je _power_n_done
  cmpq $1, -16(%rbp)
  je _power_n_done

_power_n_loop:
  #This is a do-while (b is greater than 1)
  imul -8(%rbp), %rdi
  decq -16(%rbp)
  cmpq $1, -16(%rbp)
  jne _power_n_loop
  jmp _power_n_done
  
_power_n_one:
  mov $1, %rdi

_power_n_done:
  mov %rdi, %rax
  add $16, %rsp
  leave
  ret


/*
Prints a string to standard output, expected two arguments
using registers rdi and rsi.
The first argument is the address where the string starts
The second argument is how many bytes to print
*/
_print_n_bytes:
  push %rbp
  mov %rsp, %rbp
  push %rdi # save the string pointer
  push %rsi # save the size to write
  mov $SYS_WRITE, %rax
	mov $STDOUT, %rdi 
	pop %rdx # fill the size to write argument
	pop %rsi # fill the string pointer to write
	syscall
	leave
	ret
	
/*
Call exit with an exit code stored in register rdi
*/
_exit:
  mov $SYS_EXIT, %rax
	syscall
	
.bss
digitSpace: .space 100
