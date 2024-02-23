#include "Matrix.hpp"
Matrix::Matrix(int row,int col){ //含参构造函数，接收输入并赋值 
	this->row =row;this->col=col;
	mat=new int*[row];
	int a;
	for(int i=0;i<row;i++){
		mat[i]=new int[col];
		for(int j=0;j<col;j++){
			cin>>a;
			mat[i][j]=a;
		}
	}
}
void Matrix::add(const Matrix& other){
	for(int i=0;i<row;i++){
		for(int j=0;j<col;j++){
			mat[i][j]+=other.mat[i][j];
		}
	}
}
Matrix::~Matrix(){
	for(int i=0;i<row;i++)delete []mat[i];
	delete []mat;
	mat=NULL;
	row=col=0;
}
