.include "utils.s"

.global main
.type main function

.text

main:
  mov $string, %rdi
  call _print_string
  ret
  
.data
string: .asciz "Hello\n"
