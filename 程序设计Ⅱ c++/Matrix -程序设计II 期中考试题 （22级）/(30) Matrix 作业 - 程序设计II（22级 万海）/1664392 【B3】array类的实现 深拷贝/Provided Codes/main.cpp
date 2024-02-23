#include <iostream>
#include "array.h"

int main()
{
    int n, m;

    std::cin >> n;
    array arr = array(n, -1);

    arr.print();

    for (int i = 0; i < n; ++i)
    {
        std::cin >> m;
        arr.at(i) = m;
    }

    arr.print();

    array copy_arr = array(arr);

    copy_arr.print();

    for (int i = 0; i < n; ++i) {
        copy_arr.at(i) = m;
    }

    copy_arr.print();
    arr.print();
}