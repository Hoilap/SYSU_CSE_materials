#ifndef FUNCTION_H_INCLUDED
#define FUNCTION_H_INCLUDED

class DATE   // DATE.h----Specification file of class DATE
{
    public:
        DATE();
        DATE(int newYear, int newMonth, int newDay);
        ~DATE();
        int getMonth() const;
        int getDay() const;
        int getYear() const;
        bool isLeapYear() const;
        int daysInMonth() const;
        
    private:
        int month;
        int day;
        int year;
};


#endif  // FUNCTION_H_INCLUDED
