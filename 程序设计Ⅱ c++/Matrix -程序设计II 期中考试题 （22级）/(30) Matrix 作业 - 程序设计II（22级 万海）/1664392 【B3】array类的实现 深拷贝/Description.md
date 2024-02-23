# 【B3】array类的实现 深拷贝

## 问题描述

`std::array`提供了`[]`、`at`、`front`、`back`,`data`等方法；
请在`array.cpp`中实现`array.h`中的其中的部分成员函数

```cpp
// 分配可以容纳size个元素的内存，每个元素赋值为val
array(int size, int val);
array(const array &another);
~array();
// 返回pos位置的元素的引用
int &at(int pos);
```

## 输入

+ 第一行是一个整数n
+ 接下来n行，每行是一个整数

```
3
1
2
3
```

## 输出

```
-1
-1
-1
1
2
3
1
2
3
3
3
3
1
2
3
```

