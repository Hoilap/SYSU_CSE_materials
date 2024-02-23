#include <vector>
#include <numeric>
#include <iostream>
#include<cstdlib>
#include "complex.h"
using namespace std;


COMPLEX::COMPLEX(double r, double i){ // 构造函数,定义时把默认函数删掉
    real=r;
    image=i;
}
COMPLEX::COMPLEX(const COMPLEX &other){
    real=other.real;
    image=other.image;
}// 拷贝构造函数
void COMPLEX::print(){
    cout<<real;
    if(image>0) cout<<"+"<<image<<"i"<<endl;
    else if (image<0 )  cout<<image<<"i"<<endl;
}// 打印复数

COMPLEX COMPLEX::operator+(const COMPLEX &other){
    COMPLEX ans;
    ans.real=real+other.real;
    ans.image=image+other.image;
    return ans;
}// 重载加法运算符（二元）
COMPLEX COMPLEX::operator-(const COMPLEX &other){
    COMPLEX ans;
    ans.real=real-other.real;
    ans.image=image-other.image;
    return ans;
} // 重载减法运算符（二元）
COMPLEX COMPLEX::operator-(){
    COMPLEX ans;
    ans.real=-real;
    ans.image=-image;
    return ans;
} // 重载求负运算符（一元）
COMPLEX COMPLEX::operator=(const COMPLEX &other){
    real=other.real;
    image=other.image;
    return *this;
} // 重载赋值运算符（二元）

COMPLEX & COMPLEX::operator++(){
    real=real+1;
    return *this;
}   //重载前置++
COMPLEX COMPLEX::operator++(int){
    COMPLEX ans;
    ans=*this;
    real=real+1;
    return ans;
} //重载后置++
COMPLEX & COMPLEX::operator--(){
    real=real-1;
    return *this;
}   //重载前置--
COMPLEX COMPLEX::operator--(int){
    COMPLEX ans;
    ans=*this;
    real=real-1;
    return ans;
} //重载后置--