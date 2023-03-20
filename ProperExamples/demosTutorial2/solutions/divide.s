/*
Given two positive numbers a and b, return the integer division of a/b.
You are not allowed to use division nor shift. The result will be returned
as the program's exit code.

Compile as: gcc divide.s -z noexecstack -no-pie -o divide
Run as: ./divide ; echo $?

note: the -no-pie flag is needed because we are referring to data values
directly, and one security feature that is enabled by default is to have
randomize memory addresses on each execution, but if we did that then the address for
arg1, arg2, and arg3 would change on each execution and we would need to use
relative addresses.
*/

.global main
.type main function

.text

main:
  /*
  
    pseudo C-like code
    res = 0
    while (a - b >= 0)
      a = a - b;
      res++;
    return res
  
    pseudo GOTO-like code
    goto test
    
    loop:
      a = a - b;
      res++
    
    test:
      if (a - b >= 0)
        goto loop
        
    done:
      return res;
  */
  push %rbp
  mov %rsp, %rbp
  mov valuea, %dil
  mov valueb, %sil
  mov $0, %dl
  jmp test
  
loop:
  sub %sil, %dil
  inc %dl
  
test:
  cmp %sil, %dil
  jge loop

done:
  mov %dl, %al
  leave
  ret


.data
valuea: .byte 10
valueb: .byte 3
