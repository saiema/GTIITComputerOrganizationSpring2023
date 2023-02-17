	.file	"simpleswitch.c"
	.text
	.globl	canEnterClassroom
	.type	canEnterClassroom, @function
canEnterClassroom:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	$111, %eax
	cmpl	$7, %eax
	ja	.L2
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L4(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L4(%rip), %rdx
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L4:
	.long	.L5-.L4
	.long	.L5-.L4
	.long	.L5-.L4
	.long	.L2-.L4
	.long	.L2-.L4
	.long	.L3-.L4
	.long	.L3-.L4
	.long	.L3-.L4
	.text
.L5:
	movl	$1, -4(%rbp)
	jmp	.L6
.L3:
	movl	$0, -4(%rbp)
	jmp	.L6
.L2:
	movl	$0, %eax
	jmp	.L1
.L6:
.L1:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	canEnterClassroom, .-canEnterClassroom
	.ident	"GCC: (Ubuntu 12.2.0-3ubuntu1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
