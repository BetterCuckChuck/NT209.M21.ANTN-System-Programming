.section .data
	hihi:
	.string "Nhap so: "
string_len = . -hihi
	newline:
	.ascii "\n"
.section .bss
	.lcomm x, 3
	.lcomm y, 3

.section .text
.globl _start

_start:
	# input x
	movl $4, %eax
	movl $1, %ebx
	movl $hihi, %ecx
	movl $string_len, %edx
	int $0x80
	
	movl $0, %ebx
	movl $3, %eax
	movl $x, %ecx
	movl $3, %edx
	int $0x80
	
	# store x and calc (x-1)
	movzbl x, %edi
	subl $'0', %edi
	imull $10, %edi
	
	movzbl x+1, %eax
	subl $'0', %eax
	addl %eax, %edi
	
	# calc [(x-1)/10]
	decl %edi
	movl $10, %ecx
	movl %edi, %eax
	xorl %edx, %edx
	divl %ecx
	
	# store [(x-1)/10] in %edi
	movl %eax, %edi

	################################################
	# Repeat the same process for y		       #
	################################################
	
	# input y
        movl $4, %eax
        movl $1, %ebx
        movl $hihi, %ecx
        movl $string_len, %edx 
        int $0x80

        movl $0, %ebx
        movl $3, %eax
        movl $y, %ecx
        movl $3, %edx
        int $0x80

        # store y
        movzwl y, %eax
        subb $'0', %al
	subb $'0', %ah

	movzbl %al, %ecx
    	imull $10, %ecx
    	movzbl %ah, %edx
    	addl %edx, %ecx	 # y now in %ecx
	
	# calc [y/10]
	movl %ecx, %eax	
        movl $10, %ecx
        xorl %edx, %edx
        divl %ecx

	# store y in %esi
	movl %eax, %esi
	

	# calc %esi - %edi -> output %esi
	subl %edi, %esi
	addl $'0', %esi
	pushl %esi
	
	movl $4, %eax
        movl $1, %ebx
        movl %esp, %ecx
        movl $1, %edx
        int $0x80

	# in dau xuong dong
	movl $4, %eax
	movl $1, %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $0x80

	# return 0 and exit
	movl $1, %eax
    	xorl %ebx, %ebx
    	int $0x80
