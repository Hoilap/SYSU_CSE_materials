#ifndef OBJECT_HPP
#define OBJECT_HPP
#include<iostream>
using namespace std;

class Object
{
public:
	
	Object(int a);
	Object(const Object& a);
	void print_data()
	{
		for (int i = 0; i < size; i++)
		{
			cout << data[i] << " ";
		}
		cout << endl;
	}
	~Object();

private:
	int* data;
	int size;
};

#endif