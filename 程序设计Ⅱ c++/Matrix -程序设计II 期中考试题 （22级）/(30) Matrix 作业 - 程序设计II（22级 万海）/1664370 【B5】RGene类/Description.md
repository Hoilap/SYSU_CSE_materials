# 【B5】RGene类

## 题目描述

RNA序列通常由一串形如`AAAGUCUGAC`的字母来表示。头文件`RGene.hpp`定义了一个简单的RNA基因类RGene，请根据头文件定义和后面的Hint部分对RGene类的实现进行补充。


## 输入输出

### 输入格式

第一行输入两条RNA序列的长度。第二第三行分别以字母序列的形式输入具体的RNA序列（长度与第一行指定的一致）。

### 输出格式

将输入的两条RNA序列原样输出，并输出第二条RNA序列的转录产物。

当RNA序列为空指针时，函数`printSeq()`输出一行`empty data`（最后有换行）。

## 样例

### 输入样例1

```C++
5 6
AUGCU
CUGAAG
```

### 输出样例1

```C++
RNA sequence v1:
AUGCU
RNA sequence v2:
CUGAAG
RNA sequence v2 is transcribed into:
GACUUC
```

## 提示

成员函数`RGene trans()const`需要返回由RNA序列转录得到的mRNA。mRNA和原来的RNA序列互补，本题采用的是一种最常见的互补原则：

```C++
A -- U
G -- C
```

注意若RNA序列为空，则函数返回的转录结果也为空。
另外，拷贝构造时要注意深拷贝。

