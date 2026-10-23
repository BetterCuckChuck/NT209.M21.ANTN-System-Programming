.section .data
msg:
	.string "IloveCR7"
msg_len = . -msg-1 # lay dia chi hien tai - dia chi msg - 1 (do null-terminated string).

output:
	.byte msg_len + 0x30 # cong 48 de chuyen thanh ascii string
	.byte 0x0a # '\n' xuong dong

.section .text
	.globl _start
_start:
	movl $output, %ecx
	movl $0x2, %edx
	movl $0x1, %ebx
	movl $0x4, %eax
	int $0x80 # goi write, dia chi buffer la output, viet 2 ki tu, fd = 1
	movl $0x1, %eax # goi exit
	int $0x80
