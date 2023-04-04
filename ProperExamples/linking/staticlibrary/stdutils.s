.global _exit
.type _exit function

.text

.equ SYS_EXIT, 60
	
/*
Call the exit system function with a provided exit code
*/
_exit:
    mov $SYS_EXIT, %rax
    syscall
