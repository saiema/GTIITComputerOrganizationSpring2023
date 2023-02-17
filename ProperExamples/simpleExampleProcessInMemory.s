/*
* A simple assembly program that
* calls malloc to allocate some memory
* in the heap. This program will print
* a message stating the success or failure
* of the malloc function.
* 
* This example can also be used to see where
* text, initialized data, uninitialized data,
* and heap memory is located.
*/

.global _main
.type _main function
.extern _exit
.type _exit function

.text

_main:
  mov $4, %rdi
  call malloc
  cmp $0, %rax
  jne _succeded_malloc
  
_failed_malloc:
  mov $format, %rdi
  mov $mallocFailed, %rsi
  call printf
  jmp _done
  
_succeded_malloc:
  mov $format, %rdi
  mov $mallocSucceded, %rsi
  call printf
  
_done:
  call _exit
  
.bss #unintialized data
.lcomm localSymbol, 4

.data
myData: .quad 4
format: .asciz "%s\n"
mallocFailed: .asciz "Malloc failed!"
mallocSucceded: .asciz "Malloc succeded!"

