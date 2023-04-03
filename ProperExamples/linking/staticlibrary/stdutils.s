.global _exit
.type _exit function

.text

.equ SYS_EXIT, 60
	
/*
Call exit with an exit code stored in register rdi
*/
_exit:
    mov $SYS_EXIT, %rax
    syscall
