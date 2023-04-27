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
      found = currentChar() == char
      nextChar(idx);
    return found
  
    pseudo GOTO-like code
    goto test
    
    loop:
      found = currentChar() == char
      nextChar(idx);
    
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
  mov $0, %cl       # We will use this register as a counter, and we will increment in amounts of 8 (one character at a time)
  mov $0, %al       # Since we want to return the value in found, we can use al to store it
  jmp test
  
loop:
  mov %dil, %r10b   # We will move %dil (where our character to search is) into another register to be able to do a xor without affecting our character-to-look
  xor %sil, %r10b   # If the current character (at %dil) is the same as the one we are searching for then xor will give a 0
  sete %al          # We will update %al (our found variable) with the Zero Flag value
  shr $8, %rdi      # Shifting by 8 will give use the next character in %dil
  add $8, %cl       # We need to increase our counter by 8 (one character seen)
  
test:
  cmp $1, %al       # Have we found our character yet? (is found == 1?)
  setne %r8b        # We save found != 1 into %r8b
  cmp %cl, size     # Have we seen all characters (did our counter reached the size of the string(8*8)?)
  setg %r9b         # We save (size > counter) into %r9b
  and %r8b, %r9b    # We check both conditions to see if both hold
  jnz loop          # If the result of the and is not 0 (both conditions hold) we execute the loop body
  
done:
  leave
  ret


.data
string: .ascii "Hello!\n\0"     # The string where to look for the character (8 bytes)
char: .ascii "l"                # The character to look for (1 byte)
size: .byte 64                  # The size of the string is 8 bytes, each one is 8 bits, so 8 * 8
