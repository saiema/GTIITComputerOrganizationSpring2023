.global main
.type main function
.extern _print_string
.type _print_string function

.text

main:
  mov $string, %rdi
  call _print_string
  ret
  
.data
string: .asciz "Hello\n"
