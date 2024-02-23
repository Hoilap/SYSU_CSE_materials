#include <iostream>
#include "Student.hpp"

using namespace std;

Date::Date(){}
Date::Date(int year, int month, int day) 
{
	this->year = year;
	this->month = month;
	this->day = day;
}

int Date::getYear() 
{
	return year;
}

void Date::setYear(int year) 
{
	this->year = year;
}

int Date::getMonth() 
{
	return month;
}

int Date::getDay() 
{
	return day;
}

void Date::setMonth(int month) 
{
	this->month = month;
}

void Date::setDay(int day) 
{
	this->day = day;
}

void Date::Print()
{
	cout << year << " " << month << " " << day << endl;
}


Student::Student(int Id, int year, int month, int day) 
{
	id = Id;
	birthDate = new Date(year, month, day);
	numberOfObjects++;
}

Student::~Student() 
{
	delete birthDate;
	birthDate=NULL;
	numberOfObjects--;
}


int Student::getId() 
{
	return id;
}

Date *Student::getBirthDate() const 
{
	return birthDate;
}

int Student::getNumberOfObjects() 
{
	return numberOfObjects;
}

int Student::numberOfObjects = 0;