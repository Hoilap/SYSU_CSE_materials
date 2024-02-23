#include <iostream>
#include "myspace.hpp"

int sum = 0;
int size = 0;

int main() {
    myspace::read();
    myspace::cout();
    std::cout << sum << " " << size << std::endl;
}