#include "array.h"

array::array(int size, int val)
{
    this->size = size;
    this->data = new int[size];
    for (int i = 0; i < size; ++i)
    {
        this->data[i] = val;
    }
}

array::array(const array &another)
{
    this->size = another.size;
    this->data = new int[this->size];
    for (int i = 0; i < size; ++i)
    {
        this->data[i] = another.data[i];
    }
}

array::~array()
{
    if (data)
        delete[] data;
}

int &array::at(int pos)
{
    return data[pos];
}