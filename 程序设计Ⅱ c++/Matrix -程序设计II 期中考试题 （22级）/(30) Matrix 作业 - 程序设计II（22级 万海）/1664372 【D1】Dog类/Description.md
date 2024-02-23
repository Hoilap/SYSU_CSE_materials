# 【D1】Dog类

## 问题描述

**请根据Dog.h实现Dog类相关函数**

* `string name` 字符串表示姓名
* `int id` 表示编号，编号的初始值由对象的数量决定，即第一个对象`id`为1，第二个对象`id`为2……
* `int age`表示年龄
  **其中**`name`的更改只能发生一次（初始化次数不算入内），如果发生第二次或以上的更改则输出`Set name failed!`信息。

## 样例输入

```
Tom James
```

## 样例输出

```
id: 1    name: Tom       age: 1
id: 2    name: James     age: 2
id: 1    name: James     age: 2
Set name failed!
id: 1    name: James     age: 3
```

