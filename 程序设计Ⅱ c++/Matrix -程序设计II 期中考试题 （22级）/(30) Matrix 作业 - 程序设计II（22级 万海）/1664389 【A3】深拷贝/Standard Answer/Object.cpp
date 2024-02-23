#include"Object.hpp"

Object::Object(int a)
{
	size = a;
	data = new int[size];
	for (int i = 0; i < size; i++)
	{
		data[i] = i + 1;
	}
}

Object::Object(const Object& a)
{
	size = a.size;
	data = new int[size];
	for (int i = 0; i < size; i++)
	{
		data[i] = a.data[i];
	}
}
Object::~Object()
{
	delete[] data;
}