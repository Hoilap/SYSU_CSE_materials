#include "Date.h"
#include <iostream>
using namespace std;

void Print(const DATE& date) //print the date
{
    int month = date.getMonth();
    int day = date.getDay();
    int year = date.getYear();

    switch (month)
    {
        case 1 :
            cout << "January";
            break;
        case 2 :
            cout << "February";
            break;
        case 3 :
            cout << "March";
            break;
        case 4 :
            cout << "April";
            break;
        case 5 :
            cout << "May";
            break;
        case 6 :
            cout << "June";
            break;
        case 7 :
            cout << "July";
            break;
        case 8 :
            cout << "August";
            break;
        case 9 :
            cout << "September";
            break;
        case 10 :
            cout << "October";
            break;
        case 11 :
            cout << "November";
            break;
        case 12 :
            cout << "December";
            break;
    }
    cout << ' ' << day << ", " << year << endl;
}
void leapYear(DATE& date)
{
    if(date.isLeapYear()){
        cout << date.getYear() << " is a leap year." << endl;
     }else{
        cout << date.getYear() << " is not a leap year." << endl;
     }
}
void daysOfMonth(DATE& date)
{
    cout << "Month of This DATE has " <<  date.daysInMonth() << " days." << endl;
}
int main()
{
     DATE date1;
     int tmp;
     Print(date1);

     int year, month, day;

     cin >> year >> month >> day;

     DATE date2(year, month, day );
     Print(date2);
     leapYear(date2);
     daysOfMonth(date2);

     tmp = date1.getYear();
     tmp++;

     DATE date3(tmp, 12, 20);
     Print(date3);
     leapYear(date3);
     daysOfMonth(date3);
     return 0;
}