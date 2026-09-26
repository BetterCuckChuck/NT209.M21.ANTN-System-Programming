#include <stdio.h>
//1.1
int negative(int x)
{ // Với số nguyên bù 2, ta có: -x = ~x + 1
    return (~x + 1);
}

//1.2
int cal100x(int x)
{ // 100 biểu diễn nhị phân là: 1100100 = 2^6 + 2^5 + 2^2 -> lấy tổng
    return (x << 6) + (x << 5) + (x << 2);
}

//1.3
int flipByte(int x, int n)
{ // mask sẽ set full 1 ở vị trí byte cần flip, sau đó sẽ được XOR để flip bits
    int mask = (0xff) << (n << 3);
    return x ^ mask;
}
//1.4
unsigned getnbit(unsigned x, int n)
{ // Tạo bitmask để lấy n bit cuối
    int mask_lastn = (~((~0LL) << n));
    return x & mask_lastn;
}


//1.5
int round2n(int x, int n) 
{ // cộng thêm 2^(n-1) rồi chia lấy phần nguyên, sau đó nhân lại để làm tròn, nếu bit thứ (n-1) = 1 thì sẽ làm tròn lên, nếu không sẽ làm tròn xuống.
    int half = (1 << n) >> 1;
    return ((x + half) >> n) << n;
}

//2.1
int isSameSign(int x, int y) 
{ // lấy sign bit của x, y, sau đó XNOR để trả về cùng dấu / khác dấu
    int sign_x = (x >> 31) & 0x1;
    int sign_y = (y >> 31) & 0x1;
    return !(sign_x ^ sign_y);
}

//2.2
int isPositive(int x)
{ // check 2 trường hợp: bằng 0 (!x) và âm (lấy sign bit)
    return !(!x | ((x >> 31) & 0x1));
}

//2.3
int isMulpw2(int x, int n) 
{  // kiểm tra phần bên phải của bit thứ n có full bit 0 không, nếu có XOR trả về 0, nếu không sẽ khác 0
    return !(((x >> n) << n) ^ x);
}

//2.4
int isLess2n(int x, int n) 
{ // // kiểm tra phần bên trái của bit thứ n - 1 có full bit 0 không, nếu có thì số nhỏ hơn 2^n
    return !(((x >> n) << n));
}


//2.5
int logicNot(int x) 
{
    // Với x != 0, ít nhất một trong hai số (x hoặc -x) sẽ có bit dấu (bit 31) bằng 1.
    // Riêng x = 0 thì cả x và -x đều có bit dấu bằng 0.
    int neg_x = ~x + 1;
    int has_sign = (x | neg_x) >> 31; // 0 nếu x == 0, và -1 (0xFFFFFFFF) nếu x != 0
    
    return has_sign + 1;            // 0 + 1 = 1; (-1) + 1 = 0
}

int main()
{
    int score = 0;
    // 1.1
    printf("1.1 negative");
    if (negative(0) == 0 && negative(9) == -9 && negative(-5) == 5)
    {
        printf("\t\tPass.");
        score += 1;
    }
    else
        printf("\t\tFailed.");

    //1.2
    printf("\n1.2 cal100x");
    if (cal100x(0)==0 && cal100x(9)== 900 && cal100x(-5)==-500)
    {
        printf("\t\t\tPass.");
        score += 1;
    }
    else
        printf("\t\t\tFailed.");

    //1.3
    printf("\n1.3 flipByte");
    if (flipByte(10,0)==245 && flipByte(0,1)==65280 && flipByte(0x5501,1)==0xaa01)
    {
        printf("\t\tPass.");
        score += 2;
    }
    else
        printf("\t\tFailed.");

    //1.4
    printf("\n1.4 getnbit");
    if (getnbit(15,3)==7 && getnbit(63,6)==63 && getnbit(30,2)==2)
    {
        if (getnbit(10, 32) == 10 && getnbit(-50, 35) == -50)
        {
            printf("\t\t\tAdvanced Pass.");
            score += 3;
        }
        else
        {
            printf("\t\t\tPass.");
            score += 2;
        }
    }
    else
        printf("\t\t\tFailed.");

    //1.5
    printf("\n1.5 round2n");
    if (round2n(10,3)== 8 && round2n(16,2)==16 && round2n(70,6) == 64)
    {
        if(round2n(15,3)==16 && round2n(20,5)==32)
        {
            printf("\t\t\tAdvanced Pass.");
            score +=3;
        }
        else
        {
            printf("\t\t\tPass.");
            score += 2;
        }
    }
    else
        printf("\t\t\tFailed.");


    //2.1
    printf("\n2.1 isSameSign");
    if (isSameSign(2,-2)==0 && isSameSign(-5,10)==0 && isSameSign(0,16)==1 && isSameSign(-4,-20)==1)
    {
        printf("\t\tPass.");
        score += 1;
    }
    else
        printf("\t\tFailed.");

    //2.2
    printf("\n2.2 isPositive");
    if (isPositive(10)==1 && isPositive(-105)==0 && isPositive(0)==0)
    {
        printf("\t\tPass.");
        score += 2;
    }
    else
        printf("\t\tFailed.");

    //2.3
    printf("\n2.3 isMulpw2");
    if (isMulpw2(16,4)==1 && isMulpw2(10,2)==0 && isMulpw2(48,3)==1)
    {
        printf("\t\tPass.");
        score += 2;
    }
    else
        printf("\t\tFailed.");

    //2.4
    printf("\n2.4 isLess2n");
    if (isLess2n(15,1)==0 && isLess2n(8,3)==0 && isLess2n(12,4)==1 && isLess2n(63,6)==1)
    {
        printf("\t\tPass.");
        score += 2;
    }
    else
        printf("\t\tFailed.");

    //2.5
    printf("\n2.5 logicNot");
    if (logicNot(0)==1 && logicNot(1)==0 && logicNot(-15)==0 && logicNot(-2147483648)==0)
    {
        printf("\t\tPass.");
        score += 3;
    }
    else
        printf("\t\tFailed.");

    printf("\n------\nYour score: %.1f", (float)score / 2);
    return 0;
}