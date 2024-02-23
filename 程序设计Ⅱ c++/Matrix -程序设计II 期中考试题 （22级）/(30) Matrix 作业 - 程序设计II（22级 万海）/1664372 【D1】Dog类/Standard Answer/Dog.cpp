#include <iostream>
#include <cstring>
#include "Dog.h"
using namespace std;

Dog::Dog(string name, int age) {
    ifSetName=false;
    this->name = name;
    this->id = ++ count;
    this->age = age;
}
int Dog::getId() const {
    return id;
}
int Dog::getAge() const {
    return age;
}
string Dog::getName() const {
    return name;
}
bool Dog::setName(string name) {
    if (!ifSetName) {
        this->name = name;
        ifSetName = true;
    } else {
        cout << "Set name failed!" << endl;
        return false;
    }
    return true;
}
void Dog::setAge(int age) {
    this->age = age;
}
Dog::~Dog(){

}