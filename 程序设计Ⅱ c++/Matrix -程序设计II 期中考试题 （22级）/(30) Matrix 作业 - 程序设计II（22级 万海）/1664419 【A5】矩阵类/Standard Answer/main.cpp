#include <iostream>
#include"Matrix.hpp"
using namespace std;
int main() {
	int row, col;
	cin >> row >> col;
	Matrix a(row, col), b(row, col);
	cout << endl << "Matrix a:" << endl;
	a.display();
	cout << endl << "Matrix b:" << endl;
	b.display();
	a.add(b);//两个矩阵相加
	cout << endl << "Matrix a += Matrix b :" << endl;
	a.display();
	return 0;
}
