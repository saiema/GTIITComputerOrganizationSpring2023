#42.s
#
#A really simple Hello World program.
#So simple it doesn't print anything.
#
#Compile as: gcc 42.s -z noexecstack -o 42
#Run as: ./42 ; echo $?

.global main
.type main function

.text

main:
  mov $42, %rax
  ret
