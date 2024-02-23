#include"Object.hpp"

int main()
{
    int num;
    cin >> num;

    Object a(num);
    Object b(a);
    cout << "a's data is ";
    a.print_data();
    cout << "b's data is ";
    b.print_data();

    return 0;
}