# 【C1】DATE类

## 题目描述

按照**给定的Date.h和main.cpp**实现一个DATE类，其中：

* 无参数的构造函数```DATE()```会将日期初始化为2000年1月1日，**同时输出一条信息**；
* 带参数的构造函数```DATE(newYear, newMonth, newDay)```将日期初始化为指定日期，并**输出相关信息**；
* 析构函数```~DATE()```也会**输出相关信息**;
* ```isLeapYear()```用于判断DATE类的年份**是否为闰年**;
* ```daysInMonth()```会返回DATE类当前月份的最大天数（如当前日期为2000.2.1，则会输出29，因为2000年的2月最多有29天）;
* 其余的get函数返回相应的变量值

只提交`DATE`类实现，不要提交`main()`函数。

## 样例输入

```
2020 4 1
```

## 样例输出

```
A defaut DATE class has been created!
January 1, 2000
A specified DATE class has been created!
April 1, 2020
2020 is a leap year.
Month of This DATE has 30 days.
A specified DATE class has been created!
December 20, 2001
2001 is not a leap year.
Month of This DATE has 31 days.
The DATE CLASS will be destroyed.
The DATE CLASS will be destroyed.
The DATE CLASS will be destroyed.
```

## 提示

闰年判断条件：
（1）年号能被4整除且不能被100整除的为闰年；或者（2）能被400整除的为闰年。
（1）（2）满足其一即可。



