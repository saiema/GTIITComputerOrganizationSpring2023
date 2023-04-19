.global print_integer
.global print_string
.type print_integer function
.type print_string function

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
  push %rcx # the buffer to create the string representation (%rbp -16)
  mov %rdi, %rax
  
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

/*Compare two characters given as pointers*/
equalCharacters:
  push %rbp
  mov %rsp, %rbp
  mov (%rdi), %al
  mov (%rsi), %cl
  cmp %cl, %al
  jz sameChars
  mov $0, %rax
  jmp equalCharacters_done

sameChars:
  mov $1, %rax

equalCharacters_done:
  leave
  ret

	
.bss
digitSpace: .space 100
