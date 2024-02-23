#include <iostream>
#include"Matrix.hpp"
using namespace std;

Matrix::~Matrix(){
    for(int i=0;i<row;i++) delete []mat[i];
    delete []mat;
    

}
Matrix::Matrix(int row,int col):row(row),col(col){//含参构造函数，此时需要接收输入并赋值
    //忘了给matrix的rowcol赋值
    mat=new int* [row];
    for(int i=0;i<row;i++){
        mat[i]=new int [col];
    }
    for(int i=0;i<row;i++){
        for(int j=0;j<col;j++){
            int a;
            cin>>a;
            mat[i][j]=a;
        }
    }
    // for(int i=0;i<row;i++){
    //     for(int j=0;j<col;j++){
    //         cout<<mat[i][j]<<" ";
    //     }
    //     cout<<endl;
    // }
} 
void Matrix::add(const Matrix& other){
    for(int i=0;i<row;i++){
		for(int j=0;j<col;j++){
            mat[i][j]+=other.mat[i][j];
        }
	}
}