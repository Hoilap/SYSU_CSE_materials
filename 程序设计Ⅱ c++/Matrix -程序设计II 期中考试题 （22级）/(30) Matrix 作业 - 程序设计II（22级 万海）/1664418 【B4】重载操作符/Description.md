# 【B4】重载操作符

## 问题描述

重载操作符（），使得能够像调用函数一样使用对象（函数对象）

```c++
class Exchange
{
public:
void operator()(int&, int&);
};
```

## 样例输出

```
20 30
30 20
```

