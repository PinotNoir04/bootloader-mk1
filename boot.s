.code16
.global _start


_start:
	#Initialize segment registers ds & es
	xorw %ax, %ax
	movw %ax, %ds
	movw %ax, %es

	#Initialize stack segment
	movw $0x7C00, %ax
	movw %ax, %ss
	movw $0xffff, %sp

	movw $msg, %si
	call print

	call stage2

	ljmp $0x1000, $0x0000

msg: .asciz "Starting stage 1\n\r"
error_msg: .asciz "Error reading disk\n\r"

print:
	#required to exec int 0x10 teletype function
	movb $0x0e, %ah
.loop:
	lodsb
	cmpb $0x00, %al
	je .end
	int $0x10
	jmp .loop
.end:
	ret

stage2:
	movb $0x02, %ah
	movb $0x08, %al
	movb $0x00, %ch
	movb $0x02, %cl
	movb $0x00, %dh
	movb $0x00, %dl
	
	movw $0x1000, %bx
	movw %bx, %es
	xorw %bx, %bx

	int $0x13

	jc error_disk

	ret

error_disk:
	movw $error_msg, %si
	call print
	jmp .	/*equivalent to jmp $ in Intel syntax*/
