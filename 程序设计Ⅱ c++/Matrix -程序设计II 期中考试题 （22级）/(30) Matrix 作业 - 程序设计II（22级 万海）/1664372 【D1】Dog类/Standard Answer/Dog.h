#ifndef DOG_H
#define DOG_H
#include<string>
using namespace std;

class Dog{
    string name;
    int id, age;
    static int count;
    bool ifSetName;
public:
    Dog(string name, int age);
    int getId() const;
    int getAge() const;
    string getName() const;
    bool setName(string name);
    void setAge(int age);
    ~Dog();

};

#endif