.section .data
	hello:
		.ascii "Nhap nam sinh: "
	string_len = . -hello

	Thuoc:
		.ascii "Thuoc Doan TN\n"
	Thuoc_len = . -Thuoc

	Khongthuoc:
		.ascii "Khong thuoc Doan TN\n"
	Khongthuoc_len = . -Khongthuoc
	
	intuoi:
		.ascii "Tuoi: "
	intuoi_len = . -intuoi

.section .bss
	.lcomm tuoi, 5
	.lcomm out, 1

.section .text
.globl _start

_start:
	# nhap nam sinh
	movl $4, %eax
	movl $1, %ebx
	movl $hello, %ecx
	movl $string_len, %edx
	int $0x80

	movl $3, %eax
	movl $0, %ebx
	movl $tuoi, %ecx
	movl $5, %edx
	int $0x80

	# store %edi
	xorl %edi, %edi
		
	movzbl tuoi, %eax
	subl $'0', %eax
	imull $1000, %eax
	addl %eax, %edi
	
	movzbl tuoi+1, %eax
	subl $'0', %eax
	imull $100, %eax 
	addl %eax, %edi

	movzbl tuoi+2, %eax
	subl $'0', %eax
	imull $10, %eax 
	addl %eax, %edi

	movzbl tuoi+3, %eax
	subl $'0', %eax 
	addl %eax, %edi

	# Tinh tuoi: 2026 - nam_sinh => %edi
	movl $2026, %eax
	subl %edi, %eax
	movl %eax, %edi
	
	# check main
	cmpl $16, %edi
	jl ngoai_khoang
	
	cmpl $30, %edi
	jg ngoai_khoang
	
	movl $4, %eax
	movl $1, %ebx
	movl $Thuoc, %ecx
	movl $Thuoc_len, %edx
	int $0x80
	jmp nang_cao

ngoai_khoang:
	# Khong thuoc doan thanh nien
	movl $4, %eax
	movl $1, %ebx
	movl $Khongthuoc, %ecx
	movl $Khongthuoc_len, %edx
	int $0x80

nang_cao:
	movl $4, %eax
	movl $1, %ebx
	movl $intuoi, %ecx
	movl $intuoi_len, %edx
	int $0x80

	call print

done:
	movl $1, %eax
	xorl %ebx, %ebx
	int  $0x80

print:
	# so trong %eax
	movl %edi, %eax
	# bien dem esi = 0
	xorl %esi, %esi
chia_loop:
	# chia 10 lay so du
    xorl %edx, %edx
    movl $10, %ebx
    divl %ebx

	# push stack dem tiep
    addb $'0', %dl
    pushl %edx
    incl %esi

    cmpl $0, %eax
    jne chia_loop

in_loop:
	# pop stack de output
    popl %eax
    movb %al, out

    movl $4, %eax
    movl $1, %ebx
    movl $out, %ecx
    movl $1, %edx
    int $0x80

    decl %esi
    jnz in_loop
	
	ret
	