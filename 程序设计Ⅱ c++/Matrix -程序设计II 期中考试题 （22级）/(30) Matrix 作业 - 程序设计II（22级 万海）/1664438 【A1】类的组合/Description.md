# 【A1】类的组合

## 问题描述

在存在类`Point`的基础上，通过**类的组合**的方式实现类`Line`。

一条线段可以通过两个点来表示，所以类`Line`中应当有两个点。

你应当实现：

1. 显式构造函数：参数为两个`Point`对象；
2. 复制构造函数：参数为一个`Line`对象；
3. 函数：`getlen()`用于获取线段长度。

## 提示

可以

```c++
#include <cmath>
```

然后用里面的sqrt函数求开方

