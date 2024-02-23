#include <iostream>
#include "Employee.hpp"
using namespace std;

void displayStudent(Employee &worker1, Employee &worker2)
{
    cout << "worker1 id: " << worker1.getId() << endl;
    cout << "worker2 id: " << worker2.getId() << endl;
}

int main()
{
    int id;
    cin >> id;
    Employee worker1(id);
    cout << "number of Employee objects: " << Employee::getNumberOfObjects() << endl;

    Employee worker2(id);
    cout << "number of Employee objects: " << Employee::getNumberOfObjects() << endl;

    cout << "After creating worker1 and worker2" << endl;
    displayStudent(worker1, worker2);
    {
        Employee worker3(id); 
        cout << "number of Employee objects: " << Employee::getNumberOfObjects() << endl;
    }
    cout << "number of Employee objects: " << Employee::getNumberOfObjects() << endl;

    
    return 0;
}
