/*
  Given two positive numbers a and b, return the integer division of a/b.
  You are not allowed to use division nor shift. The result will be returned
  as the program's exit code.
*/

.global main
.type main function

.text

main:
  /*
  # C-like code
  divisions = 0
  while (a - b >= 0)
    division++;
    a = a - b
  return divisions

  # Goto-like code
  divisions = 0
  goto test

  loop:
    divisions++
    a = a - b

  test:
    if (a - b >= 0) 
    goto loop
    
  done:
    return divisions
  */
  push %rbp           # -------------
  mov %rsp, %rbp      # epilogue: save and update rbp
  mov value1, %dil    # -------------
  mov value2, %sil    # We will store value1 (a) into %dil, value2 (b) into %sil
  mov $0, %cl         # and we will store the amount of divisions made into %cl (this should be a local variable, but we will use a register for now)
  jmp test

loop:
  #TODO: complete
  
test:
  cmp %sil, %dil
  jge loop

done:
  #TODO: complete
  leave             # Pop and restore rbp
  ret

.data
value1: byte 7
value2: byte 3
