# 【A5】矩阵类

## 问题描述

完善矩阵类的定义，其中的成员`mat`需要使用new和delete动态创建和释放，注意在构造函数时循环输入矩阵各个元素的值。
完善矩阵加法`void add(const Matrix& other)`函数，将另一个矩阵`other`的值加入到该矩阵中。

## 输入样例

```
2 3
1 2 3
1 2 3
1 2 3
1 2 3
```

## 输出样例

```
Matrix a:
1 2 3
1 2 3

Matrix b:
1 2 3
1 2 3

Matrix a += Matrix b :
2 4 6
2 4 6
```

