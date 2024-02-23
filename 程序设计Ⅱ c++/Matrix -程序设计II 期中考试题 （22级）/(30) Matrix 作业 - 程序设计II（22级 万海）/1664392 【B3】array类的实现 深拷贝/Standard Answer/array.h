#ifndef ARRAY
#define ARRAY

#include <iostream>

class array
{
private:
    int size;  // size
    int *data; // dynamically allocate/release memory

public:
    array(int size, int val);
    array(const array &another);
    ~array();
    int &at(int pos);
    void print() const
    {
        for (int i = 0; i < size; ++i)
            std::cout << data[i] << std::endl;
    }
};

#endif