#ifndef EMPLOYEE_HPP
#define EMPLOYEE_HPP
class Employee
{
public:
    Employee(int id);
    ~Employee();
    int getId();
    static int getNumberOfObjects(); 
 
private:
    int id;
    static int numberOfObjects; //count the number of Student objects
};

#endif