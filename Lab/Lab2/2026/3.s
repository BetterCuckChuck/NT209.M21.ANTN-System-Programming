.section .rodata
enter_string:
    .ascii "Enter a string (<255 chars): "
enter_string_len = .-enter_string

shift_string:
    .ascii "Enter n (0-9): "
shift_string_len = .-shift_string

.section .bss
    .lcomm input_str, 256
    .lcomm input_len, 4
    .lcomm n, 2

.section .text
	.globl _start

# %ecx = buffer addr, %edx = len
printf:
	movl $0x1, %ebx         # stdout
	movl $0x4, %eax         # write
	int $0x80
	ret

# %ecx = buffer addr, %edx = len
read:
    xorl %ebx, %ebx         # stdin
	movl $0x3, %eax         # read
	int $0x80
	ret

cipher:
    movl $0, %ecx
    movl $input_str, %edx
    decl %edx

.cipher_loop:
    cmpl input_len, %ecx
    je .fin
    incl %edx
    incl %ecx
    cmpb $'A', (%edx)
    jb .cipher_loop     # ki tu dac biet ngoai khoang
    cmpb $'Z', (%edx)
    movb $'A', %bl
    jbe .shift # Upper case letter ('A' <= x <= 'Z')

    cmpb $'a', (%edx)
    jb .cipher_loop     # ki tu dac biet ngoai khoang
    cmpb $'z', (%edx)
    movb $'a', %bl
    jbe .shift # Lower case letter ('a' <= x <= 'z')

    # ki tu dac biet ngoai khoang
    jmp .cipher_loop

.fin:
    ret

.shift:
    movb (%edx), %al
    subb %bl, %al
    addb n, %al
    cmpb $26, %al
    jb .done
    subb $26, %al

.done:
    addb %bl, %al
    movb %al, (%edx)
    jmp .cipher_loop


_start:
    movl $enter_string, %ecx
	movl $enter_string_len, %edx
	call printf

	movl $input_str, %ecx
    movl $256, %edx
    call read
    movl %eax, input_len

    movl $shift_string, %ecx
	movl $shift_string_len, %edx
    call printf

    movl $n, %ecx
    movl $0x2, %edx
    call read
    subb $0x30, n
    call cipher

    movl $input_str, %ecx
	movl input_len, %edx
	call printf
    
    movl $1, %eax
	int $0x80
