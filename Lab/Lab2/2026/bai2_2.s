.section .data
nhapvao:
	.string  "Enter a number (2-digit): "
kq:
	.string "Remainder: "
newline:
    .byte 10
ans:
	.int 0
.section .text
	.globl _start

jmp _start

nhapso:
	movl $4, %eax
	movl $1, %ebx
    movl $nhapvao, %ecx
	movl $26, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $number1 , %ecx
	movl $3, %edx
    int $0x80

	movzbl number1, %eax
	subl $48, %eax
	imull $10, %eax

	movzbl number1+1, %ebx
	subl $48, %ebx
	addl %ebx, %eax

	addl %eax, ans 
	ret

inkq:
	movl ans, %eax
	xorl %edx, %edx
	movl $8, %ecx
	divl %ecx

	movl %edx, ans
	addl $48, ans

	movl $4, %eax
	movl $1, %ebx
	movl $kq, %ecx
	movl $11, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	movl $ans, %ecx
	movl $1, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $0x80
	ret

_start:
call nhapso
call nhapso
call nhapso
call nhapso
call inkq

mov $1, %eax
int $0x80

.section .bss
	.lcomm number1, 4


