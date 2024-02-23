#include <iostream>
#include "timer.hpp"
using namespace std;

void Timer::operator++(int) //Overload Unary Increment
{
    if (min == 59)
    {
        hr++;
        min = 0;
    }
    else
    {
        min++;
    }
}

void Timer::operator--(int) //Overload Unary Decrement
{
    if (min == 0)
    {
        hr--;
        min = 59;
    }
    else
    {
        min--;
    }
}