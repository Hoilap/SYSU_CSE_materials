#include "myspace.hpp"

extern int sum;
extern int size;

void myspace::cout() {
    std::cout << sum << std::endl;
    std::cout << (sum*1.0f/size) << std::endl;
}

void myspace::read() {
    int num;
    while(std::cin >> num) {
        sum += num;
        size ++;
    }
}