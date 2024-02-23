#include <vector>
#include <numeric>
#include <iostream>
#include<cstdlib>
#include "complex.h"
using namespace std;

int main()
{
    int val_1,val_2,val_3;
    cin >> val_1 >> val_2;
    COMPLEX c1(val_1, val_2); // 定义一个值为val_1 + val_2*i的复数c1
    cin >> val_3;
    COMPLEX c2(val_3);    // 定义一个值为val_3 + 0*i的复数c2
    COMPLEX c3(c1);   // 用拷贝构造函数创建一个值同c1的新复数

    c3.print();        // 打印c3的值
    c1 = c1 + c2 + c3; // 将c1加上c2再加上c3赋值给c1
    c2 = -c3;          // c2等于c3求负
    c3 = c2 - c1;      // c3等于c2减去c1
    c3.print();        // 再打印运算后c3的值

    COMPLEX temp= c3++;
    temp.print();
    c3.print();

    temp=c3--;
    temp.print();
    c3.print();

    temp=--c3;
    temp.print();
    c3.print();

    temp=++c3;
    temp.print();
    c3.print();   
   


    return 0;
}

