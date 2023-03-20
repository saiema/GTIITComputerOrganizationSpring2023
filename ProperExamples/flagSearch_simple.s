#flagSearch_simple.s
#
#A simple program that given a value and some flags
#will return as exit code which flags it found.
#
#Compile as: gcc flagSearch_simple.s -z noexecstack -no-pie -o flagSearch_simple
#Run as: ./flagSearch_simple ; echo $?

  .global main
  .type main function
  
.text

.equ FLAG1, 1       #00000001
.equ FLAG2, 2       #00000010
.equ FLAG4, 4       #00000100
.equ FLAG8, 8       #00001000
.equ FLAG16, 16     #00010000
.equ FLAG32, 32     #00100000

main:
  movzbq value2, %rdi  # Select value to use
  movb $FLAG1, %sil   # All flags to search
  or $FLAG4, %rsi     # you can add more using or
  and %rsi, %rdi
  mov %rdi, %rax
  ret
  
.data
value1: .byte 7 #00000111
value2: .byte 4 #00000100
value3: .byte 43 #00101011
