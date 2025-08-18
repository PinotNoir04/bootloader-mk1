.code16
.global _start_stage2
.extern kmain

_start_stage2:
	cli

	movl $gdt_descriptor, %eax
	lgdt (%eax)

	movl %cr0, %eax
	orl $0x01, %eax
	movl %eax, %cr0

	ljmpl $0x08, $protected_mode

.code32

protected_mode:
	movw $0x10, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %gs
	movw %ax, %fs
	movw %ax, %ss

	mov $0x090000, %esp

	call kmain

	cli

inf_loop:
	hlt
	jmp inf_loop

.align 4
gdt_start:
	#Null Descriptor
	.quad 0x0

	#CS Descriptor
	.quad 0x00cf9a000000ffff

	#DS Descriptor
	.quad 0x00cf92000000ffff
gdt_end:

gdt_descriptor:
  .word gdt_end - gdt_start - 1
  .long gdt_start
