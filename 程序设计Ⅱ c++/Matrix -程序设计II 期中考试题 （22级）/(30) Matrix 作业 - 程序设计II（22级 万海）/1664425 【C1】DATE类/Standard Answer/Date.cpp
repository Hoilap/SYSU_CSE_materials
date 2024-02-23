#include "Date.h"
#include <iostream>
using namespace std;

DATE::DATE(){
    month = 1;
    day = 1;
    year = 2000;
    cout << "A defaut DATE class has been created!" << endl;
}
DATE::DATE(int newYear, int newMonth, int newDay){
    year = newYear;
    month = newMonth;
    day = newDay;
    cout << "A specified DATE class has been created!" << endl;
}
DATE::~DATE(){
    cout << "The DATE CLASS will be destroyed." <<endl;
}
int DATE::getMonth() const{
    return month;
}
int DATE::getDay() const{
    return day;
}
int DATE::getYear() const{
    return year;
}

bool DATE::isLeapYear()const{
    if((year % 4) ==0){
        if((year % 100) != 0){
            return true;
        }else{
            if((year % 400) == 0){
                return true;
            }
        }
    }
    return false;
}
int DATE::daysInMonth()const{
    int days = 0;
    switch(month){
        case 4:
        case 6:
        case 9:
        case 11:
            days = 30;
            break;
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            days = 31;
            break;
    }
    if(days == 0){
        if(isLeapYear())
            days = 29;
        else 
            days = 28;
    }
    return days;
}
