#include <bits/stdc++.h>

using namespace std;

void PrintBits(unsigned int x) {
    int i;
    for (i = 8 * sizeof(x)-1; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}

void PrintBitsOfByte(unsigned int x) {
    int i;
    for (i = 7; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}

int bitOr(int x, int y)
{
    return ~(~x & ~y);
}

int bitAnd(int x, int y)
{
    return ~(~x | ~y);
}

int negative(int x)
{
    return (~x + 1);
}

int flipByte(int x, int n)
{
    return x ^ (((1 << 8) - 1) << (8 * n));
}

int getnbit(int x, int n)
{
    return x & ((1LL << n) - 1);
}

int divpw2(int x, int n)
{
    if (n < 0)
    {
        return x << (-n);
    }
    else
    {
        return x >> n;
    }
}

int isOpposite(int x, int y)
{
    if (x == negative(y)) return 1;
    return 0;
}

int is8x(int x)
{
    if ((x & ((1 << 3) - 1)) == 0) return 1;
    return 0;
}

int isPositive(int x)
{
    if (!x) return 0;
    if ((((x) >> 31) & 0x1) == 0) return 1;
    return 0; 
}

int isGE2n(int x, int n)
{
    if (x >= (1 << n)) return 1;
    return 0;
}

int logicNot(int x)
{
    if (x) return 0;
    return 1;
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
    if (divpw2(10, -1) == 20 && divpw2(15, -2) == 60 && divpw2(2, -4) == 32)
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