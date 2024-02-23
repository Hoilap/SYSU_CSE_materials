#include <iostream>
#include "Student.hpp"
using namespace std;

void displayStudent(Student &student1, Student &student2)
{
    cout << "student1 id: " << student1.getId() << endl;
    cout << "student1 birthday: ";
	student1.getBirthDate() -> Print();
    cout << "student2 id: " << student2.getId() << endl;
    cout << "student2 birth year: ";
	student2.getBirthDate() -> Print();
}

int main()
{
    int id, year, month, day, year2;
    cin >> id >> year >> month >> day;
    Student student1(id, year, month, day);
    cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;

    Student student2(id, year, month, day);
    cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;

    cout << "After creating student1 and student2" << endl;
    displayStudent(student1, student2);
    cout << (student1.getBirthDate() == student2.getBirthDate()) << endl;

    cin >> year2;
    student2.getBirthDate() -> setYear(year2);
    cout << "After modifying student2's birthDate" << endl;
    displayStudent(student1, student2);

    Student* p_student3 = &student1;
    cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;
	cout << (p_student3->getBirthDate() == student1.getBirthDate()) << endl; 
	
    {
        Student student5(id, year, month, day); 
        cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;
    }
    cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;


    p_student3 = NULL;
    cout << "number of Student objects: " << Student::getNumberOfObjects() << endl;
    
    return 0;
}
