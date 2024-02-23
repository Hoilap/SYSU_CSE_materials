# 【D3】深拷贝

## 题目描述

完善以下类的成员函数，其中 size 是 data 指针所指向的内存地址长度， data 记录区间[1,size]内 的 int 类型数字

```
class Object
{
public:
	
	Object(int a);
	Object(const Object& a);
	void print_data()
	{
		for (int i = 0; i < size; i++)
		{
			cout << data[i] << " ";
		}
		cout << endl;
	}
	~Object();

private:
	int* data;
	int size;
};
```

## 样例输入

```
10
```

## 样例输出

```
a's data is 1 2 3 4 5 6 7 8 9 10
b's data is 1 2 3 4 5 6 7 8 9 10
```

