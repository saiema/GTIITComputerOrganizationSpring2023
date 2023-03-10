#flagSearch_simple_noC.s
#
#A simple program that given a value and some flags
#will return as exit code which flags it found.
#
#Assemble as: gcc -c flagSearch_simple_noC.s
#Link as: ld flagSearch_simple_noC.o -o flagSearch_simple_noC
#Run as: ./flagSearch_simple_noC ; echo $?

  .global _start
  .type _start function
  
.text

.equ FLAG1, 1       #00000001
.equ FLAG2, 2       #00000010
.equ FLAG4, 4       #00000100
.equ FLAG8, 8       #00001000

_start:
  movzbq value3, %rdi  # Select value to use
  movb $FLAG1, %sil   # All flags to search
  or $FLAG8, %rsi     # you can add more using or
  and %rsi, %rdi
  # There is no need to again move the exit code to rdi
  mov $60, %rax
  syscall

.data
value1: .byte 7 #00000111
value2: .byte 4 #00000100
value3: .byte 43 #00101011

