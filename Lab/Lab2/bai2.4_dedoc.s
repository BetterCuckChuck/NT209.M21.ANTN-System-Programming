# ==============================================================================
# CHƯƠNG TRÌNH: ĐẾM SỐ LƯỢNG BỘI CỦA 10 TRONG KHOẢNG [x, y] (10 <= x <= y <= 99)
# CÔNG THỨC:    Kết quả = [y / 10] - [(x - 1) / 10]
# THANH GHI:    %edi: Lưu [(x - 1) / 10]
#               %esi: Lưu [y / 10] -> Kết quả cuối cùng
# ==============================================================================

.section .data
    hihi:
        .string "Nhap so: "
    string_len = . - hihi

.section .bss
    .lcomm x, 3                         # 2 chữ số + phím Enter
    .lcomm y, 3                         # 2 chữ số + phím Enter

.section .text
.globl _start

# ------------------------------------------------------------------------------
# ENTRY POINT
# ------------------------------------------------------------------------------
_start:
    jmp module_input_x

# ------------------------------------------------------------------------------
# MODULE 1: NHẬP VÀ XỬ LÝ SỐ NGUYÊN X
# Đầu ra: %edi = [(x - 1) / 10]
# ------------------------------------------------------------------------------
module_input_x:
    # 1.1 In lời nhắc "Nhap so: "
    movl    $4, %eax
    movl    $1, %ebx
    movl    $hihi, %ecx
    movl    $string_len, %edx
    int     $0x80

    # 1.2 Đọc 3 byte vào buffer x
    movl    $0, %ebx
    movl    $3, %eax
    movl    $x, %ecx
    movl    $3, %edx
    int     $0x80

module_calc_x:
    # 1.3 Chuyển chuỗi x thành số nguyên (phương pháp tách từng byte)
    movzbl  x, %edi                     # %edi = chữ số hàng chục
    subl    $'0', %edi
    imull   $10, %edi                   # %edi = hàng chục * 10

    movzbl  x+1, %eax                   # %eax = chữ số hàng đơn vị
    subl    $'0', %eax
    addl    %eax, %edi                  # %edi = giá trị số nguyên x

    # 1.4 Tính [(x - 1) / 10]
    decl    %edi                        # %edi = x - 1
    movl    $10, %ecx                   # Số chia = 10
    movl    %edi, %eax                  # Số bị chia nạp vào %eax
    xorl    %edx, %edx                  # Xóa sạch phần dư %edx trước khi chia
    divl    %ecx                        # %eax = [(x - 1) / 10]

    # 1.5 Cất kết quả của x vào %edi
    movl    %eax, %edi

    jmp     module_input_y

# ------------------------------------------------------------------------------
# MODULE 2: NHẬP VÀ XỬ LÝ SỐ NGUYÊN Y
# Đầu ra: %esi = [y / 10]
# ------------------------------------------------------------------------------
module_input_y:
    # 2.1 In lời nhắc "Nhap so: "
    movl    $4, %eax
    movl    $1, %ebx
    movl    $hihi, %ecx
    movl    $string_len, %edx 
    int     $0x80

    # 2.2 Đọc 3 byte vào buffer y
    movl    $0, %ebx
    movl    $3, %eax
    movl    $y, %ecx
    movl    $3, %edx
    int     $0x80

module_calc_y:
    # 2.3 Chuyển chuỗi y thành số nguyên (phương pháp movzwl 2 byte)
    movzwl  y, %eax
    subb    $'0', %al                   # %al = hàng chục
    subb    $'0', %ah                   # %ah = hàng đơn vị

    movzbl  %al, %ecx
    imull   $10, %ecx                   # %ecx = hàng chục * 10
    movzbl  %ah, %edx
    addl    %edx, %ecx                  # %ecx = giá trị số nguyên y

    # 2.4 Tính [y / 10]
    movl    %ecx, %eax                  # Số bị chia nạp vào %eax
    movl    $10, %ecx                   # Số chia = 10
    xorl    %edx, %edx                  # Xóa sạch phần dư %edx
    divl    %ecx                        # %eax = [y / 10]

    # 2.5 Cất kết quả của y vào %esi
    movl    %eax, %esi

    jmp     module_output

# ------------------------------------------------------------------------------
# MODULE 3: TÍNH TOÁN HIỆU SỐ VÀ XUẤT MÀN HÌNH
# Tính: %esi = %esi - %edi = [y / 10] - [(x - 1) / 10]
# ------------------------------------------------------------------------------
module_output:
    subl    %edi, %esi                  # %esi = số lượng bội của 10
    addl    $'0', %esi                  # Chuyển số sang ký tự ASCII
    pushl   %esi                        # Đẩy vào Stack để lấy địa chỉ bộ nhớ

    # In 1 byte kết quả từ đỉnh Stack
    movl    $4, %eax
    movl    $1, %ebx
    movl    %esp, %ecx
    movl    $1, %edx
    int     $0x80

    jmp     module_exit

# ------------------------------------------------------------------------------
# MODULE 4: KẾT THÚC TIẾN TRÌNH
# ------------------------------------------------------------------------------
module_exit:
    movl    $1, %eax                    # sys_exit
    xorl    %ebx, %ebx                  # return 0
    int     $0x80
