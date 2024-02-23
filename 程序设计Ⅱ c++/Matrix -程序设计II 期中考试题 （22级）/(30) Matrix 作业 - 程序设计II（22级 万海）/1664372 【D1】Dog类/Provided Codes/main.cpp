#include <iostream>
#include <iomanip>
#include "Dog.h"
using namespace std;

ostream& operator<<(ostream& os, const Dog & d) {
    os << left << "id: " << setw(5) << d.getId() 
       << "name: " << setw(10) << d.getName() 
       << "age: " << setw(10) << d.getAge();
    return os;
}

int Dog::count = 0;

int main() {
    string name1, name2;
    cin >> name1 >> name2;
    Dog a(name1, 1);
    Dog b(name2, 2);

    cout << a << endl;
    cout << b << endl;

    a.setName(name2);
    a.setAge(a.getAge()+1);
    cout << a << endl;

    a.setName("name");
    a.setAge(a.getAge()+1);
    cout << a << endl;

}