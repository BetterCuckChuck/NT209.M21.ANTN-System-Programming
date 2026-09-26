#include <bits/stdc++.h>

using namespace std;

// In ra biểu diễn nhị phân đầy đủ của x theo số bit của kiểu dữ liệu.
void PrintBits(unsigned int x) {
    int i;
    for (i = 8 * sizeof(x)-1; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}

// In ra 8 bit thấp của x theo dạng nhị phân.
void PrintBitsOfByte(unsigned int x) {
    int i;
    for (i = 7; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}

int bitOr(int x, int y)
{ // Áp dụng công thức De Morgan: x | y = ~ (~x & ~y)
    return ~(~x & ~y);
}

int bitAnd(int x, int y)
{ // Áp dụng công thức De Morgan: x & y = ~ (~x | ~y)
    return ~(~x | ~y);
}

int negative(int x)
{ // Với số nguyên bù 2, ta có: -x = ~x + 1
    return (~x + 1);
}

int cal100(int x)
{ // 100 biểu diễn nhị phân là: 1100100 = 2^6 + 2^5 + 2^2
    return (x << 6) + (x << 5) + (x << 2);
}

int flipByte(int x, int n)
{ // mask sẽ set full 1 ở vị trí byte cần flip, sau đó sẽ được XOR để flip bits
    int mask = (0xff) << (n << 3);
    return x ^ mask;
}

// Lấy n bit thấp của x bằng cách mask các bit bên ngoài phạm vi cần giữ lại.
int getnbit(int x, int n)
{ 
    return x & (~((~0) << n));
}

// Chia x cho 2^n nếu n >= 0, hoặc nhân x với 2^(-n) nếu n < 0, bằng cách sử dụng dịch bit.
int divpw2(int x, int n) {
    int mask = n >> 31;          // 0xFFFFFFFF nếu n < 0, 0x00000000 nếu n >= 0
    int shl = (~n + 1) & mask;   // Lượng dịch trái: -n khi n < 0, 0 khi n >= 0
    int shr = n & ~mask;         // Lượng dịch phải:  n khi n >= 0, 0 khi n < 0
    
    return (x << shl) >> shr;
}

// Kiểm tra xem x và y có phải là hai số đối nhau hay không bằng cách xét tổng của chúng.
int isOpposite(int x, int y)
{ // Tính tổng 2 số, nếu 2 số đối kq = 0 -> Logical not trả về 1, còn lại trả về 0
    return !(x + y);
}

// Kiểm tra x có chia hết cho 8 hay không bằng cách xét 3 bit thấp bằng 0.
int is8x(int x)
{
    return !(x & 0x7);
}

// Kiểm tra xem x có phải là số dương theo cách biểu diễn số nguyên có dấu hay không.
int isPositive(int x)
{
    return !(!x | ((x >> 31) & 0x1));
}

// Kiểm tra x có lớn hơn hoặc bằng 2^n hay không bằng cách dịch phải và xét giá trị còn lại.
int isGE2n(int x, int n)
{
    return !!(x >> n);
}

// Thực hiện phép logicNot theo cách tính dựa trên bit dấu của x và -x.
int logicNot(int x) {
    // Với x != 0, ít nhất một trong hai số (x hoặc -x) sẽ có bit dấu (bit 31) bằng 1.
    // Riêng x = 0 thì cả x và -x đều có bit dấu bằng 0.
    int neg_x = ~x + 1;             // -x trong bù 2
    int has_sign = (x | neg_x) >> 31; // 0 nếu x == 0, và -1 (0xFFFFFFFF) nếu x != 0
    
    return has_sign + 1;            // 0 + 1 = 1; (-1) + 1 = 0
}

void printTest(string_view s)
{
    cout << "Passed: " << s << "\n";
}

int main()
{
    if (bitOr(3, -9) == (3 | -9))
    {
        printTest("bitOr");
    }
    if (negative(9) == -9)
    {
        printTest("negative");
    }
    if (flipByte(10, 0) == 245 && flipByte(0, 1) == 65280 && flipByte(0x5501, 1) == 0xaa01)
    {
        printTest("flipByte");
    }
    if (getnbit(15, 3) == 7 && getnbit(63, 6) == 63 && getnbit(30, 2) == 2)
    {
        printTest("getnbit");
    }
    if (divpw2(10, 1) == 5 && divpw2(15, -2) == 60 && divpw2(2, -4) == 32)
    {
        printTest("divpw2");
    }
    if (isOpposite(2, -2) == 1 && isOpposite(5, -1) == 0 && isOpposite(0, 16) == 0 && isOpposite(-4, 4) == 1)
    {
        printTest("isOpposite");
    }
    if (is8x(16) == 1 && is8x(23) == 0 && is8x(0) == 1)
    {
        printTest("is8x");
    }
    if (isPositive(10) == 1 && isPositive(-5) == 0 && isPositive(0) == 0)
    {
        printTest("isPositive");
    }
    if (isGE2n(12, 4) == 0 && isGE2n(8, 3) == 1 && isGE2n(15, 2) == 1)
    {
        printTest("isGE2n");
    }
    if (logicNot(0) == 1 && logicNot(1) == 0 && logicNot(-15) == 0 && logicNot(-2147483648) == 0)
    {
        printTest("logicNot");
    }
}