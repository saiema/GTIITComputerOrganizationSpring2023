/*
Given a string and a character, return if the character is contained in the string (1) or not (0)
To store the string we will use a register (so 8 characters in total).

Compile as: gcc containsChar.s -z noexecstack -no-pie -o containsChar
Run as: ./containsChar ; echo $?

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
    found = 0
    idx = 0
    size = 8
    while (!found && size - idx >= 0)
      nextChar(idx);
      found = currentChar() == char
    return found
  
    pseudo GOTO-like code
    goto test
    
    loop:
      nextChar(idx);
      found = currentChar() == char
    
    test:
      if (!found && size - idx >= 0)
        goto loop
        
    done:
      return res;
  */
  push %rbp
  mov %rsp, %rbp
  mov string, %rdi
  mov char, %sil
  mov size, %dl
  mov $0, %cl
  mov $0, %al
  jmp test
  
loop:
  shr %cl, %rdi
  mov %dil, %r10b
  xor %sil, %r10b
  sete %al
  add $8, %cl
  
test:
  cmp $1, %al
  setne %r8b
  cmp %cl, size
  setge %r9b
  and %r8b, %r9b
  jnz loop
  
done:
  leave
  ret


.data
string: .ascii "Hello!!\0" #8
char: .ascii "j"
size: .byte 64 #8 * 8
