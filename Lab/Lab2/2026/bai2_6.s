.section .data
nhapvao:
	.string  "Enter a year (4-digit): "
kqnamnhuan:
	.string "Nam nhuan\n"
kqnamkhongnhuan:
    .string "Nam khong nhuan\n"
namnhuantieptheouwu:
    .string "Nam nhuan ke tiep: "
newline:
    .byte 10
ans:
	.int 0
.section .text
	.globl _start

jmp _start

namnhuantieptheo:
    addl $1, ans

    movl ans, %eax
	xorl %edx, %edx
	movl $4, %ecx
	divl %ecx
    cmpl $0, %edx 

    jne namnhuantieptheo
    
    movl ans, %eax
	xorl %edx, %edx
	movl $100, %ecx
	divl %ecx
    cmpl $0, %edx
    jne okroido

    movl ans, %eax
	xorl %edx, %edx
	movl $400, %ecx
	divl %ecx
    cmpl $0, %edx
    jne namnhuantieptheo
    
okroido:
    movl $4, %eax
    movl $1, %ebx
    movl $namnhuantieptheouwu, %ecx
    movl $19, %edx
    int $0x80

    movl ans, %eax
    movl $buffer_num + 10, %esi
    movl $0, %ecx

chuyen_doi:
    decl %esi
    xorl %edx, %edx
    movl $10, %ebx
    divl %ebx
    addb $48, %dl
    movb %dl, (%esi)
    incl %ecx
    cmpl $0, %eax
    jne chuyen_doi

    movl $4, %eax
    movl $1, %ebx
    movl %esi, %ecx
    movl $buffer_num + 10, %edx
    subl %esi, %edx
    int $0x80

    call xuonghang

superend:
    ret

xuonghang:
    movl $4, %eax
	movl $1, %ebx
	movl $newline, %ecx
	movl $1, %edx
	int $0x80
	ret


_start:
    movl $4, %eax
	movl $1, %ebx
    movl $nhapvao, %ecx
	movl $23, %edx
	int $0x80

    movl $3, %eax
	movl $0, %ebx
	movl $number1 , %ecx
	movl $5, %edx
    int $0x80

    movzbl number1, %eax
    subl $48, %eax
    imull $1000, %eax
    addl %eax, ans

    movzbl number1+1, %eax
    subl $48, %eax
    imull $100, %eax
    addl %eax, ans

    movzbl number1+2, %eax
    subl $48, %eax
    imull $10, %eax
    addl %eax, ans

    movzbl number1+3, %ebx
    subl $48, %ebx
    addl %ebx, ans

    movl $0, %ecx

    addl %eax, %ecx
    addl %ebx, %ecx

    cmpl $0, %ecx
    je tieptuckiemtra
    jmp saudo

tieptuckiemtra:
    movl ans, %eax
	xorl %edx, %edx
	movl $400, %ecx
	divl %ecx
    cmpl $0, %edx
    jne namkhongnhuan
lanamnhuan:
    movl $4, %eax
	movl $1, %ebx
	movl $kqnamnhuan, %ecx
	movl $10, %edx
	int $0x80
    jmp end
namkhongnhuan:
    movl $4, %eax
	movl $1, %ebx
	movl $kqnamkhongnhuan, %ecx
	movl $16, %edx
	int $0x80
    jmp end

saudo:

    movl $0, ans

    movzbl number1+2, %eax
    subl $48, %eax
    imull $10, %eax
    addl %eax, ans

    movzbl number1+3, %ebx
    subl $48, %ebx
    addl %ebx, ans

    movl ans, %eax
	xorl %edx, %edx
	movl $4, %ecx
	divl %ecx
    cmpl $0, %edx
    jne tnamkhongnhuan
tlanamnhuan:
    movl $4, %eax
	movl $1, %ebx
	movl $kqnamnhuan, %ecx
	movl $10, %edx
	int $0x80
    jmp end
tnamkhongnhuan:
    movl $4, %eax
	movl $1, %ebx
	movl $kqnamkhongnhuan, %ecx
	movl $16, %edx
	int $0x80
end:
    
    movl $0, ans

    movzbl number1, %eax
    subl $48, %eax
    imull $1000, %eax
    addl %eax, ans

    movzbl number1+1, %eax
    subl $48, %eax
    imull $100, %eax
    addl %eax, ans

    movzbl number1+2, %eax
    subl $48, %eax
    imull $10, %eax
    addl %eax, ans

    movzbl number1+3, %ebx
    subl $48, %ebx
    addl %ebx, ans

    call namnhuantieptheo

mov $1, %eax
int $0x80
.section .bss
    .lcomm number1, 5
    buffer_num: .space 16
    