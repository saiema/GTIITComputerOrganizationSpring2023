/*
Given a flag and a value, return True
  iff the value contains the flag.
*/

.global main
.type main function

.text

main:
  /* C-like code
  if (value contains flag) {
    return 0
  } else {
    return 1
  }

  # Goto-like code
  res = 1
  if (value does not contains flag)
    goto else

  then:
    res = 0 (true)
    got done

  else:
    res = 1 (false)

  done:
    return res
  */
  push %rbp       # -------------
  mov %rsp, %rbp  # epilogue: save and update rbp
  mov value, %dil # -------------
  mov flag, %sil  # We will store the flag to search into %dil, and the value where we will search the flag into %sil
  
  and %dil, %sil  # Before the "if statement" we need to calculate the condition, if the flag is not in the value, the ZF will be set to 0 
  je elseBody
  
thenBody:
  mov $0, %al
  jmp done
  
elseBody:
  mov $1, %al
  
done:
  leave
  ret

.data
flag: .byte 4 # 00000100
value: .byte 3 # 00000011
