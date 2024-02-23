#include <iostream>
#include "Employee.hpp"

using namespace std;


Employee::Employee(int Id) 
{
	id = Id;
	numberOfObjects++;
}

Employee::~Employee() 
{
	numberOfObjects--;
}


int Employee::getId() 
{
	return id;
}


int Employee::getNumberOfObjects() 
{
	return numberOfObjects;
}

int Employee::numberOfObjects = 0;