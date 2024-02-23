#ifndef MATRIX_HPP
#define MATRIX_HPP
#include <iostream>
using namespace std;
class Matrix{
	private:
		int row;
		int col;
		int ** mat;
	public:
		~Matrix();
		Matrix(int row,int col); //含参构造函数，此时需要接收输入并赋值
		void add(const Matrix& other); //与另一个矩阵对象相加 
		void display()const{
			for(int i=0;i<row;i++){
				for(int j=0;j<col;j++)
					cout<<mat[i][j]<<' ';
				cout<<endl;
			}
		}
		
};

#endif //MATRIX_HPP
