# 【A6】节点交换

## 问题描述

给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。输出末尾有空格

![image.png](/api/users/image?path=100030482/images/1682327911406.png)

## 样例输入1

```
1 2 3 4
```

## 样例输出1

```
2 1 4 3
```

## 样例输入2

```
2 3 4 5 6 7
```

## 样例输出2

```
3 2 5 4 7 6
```

## 提示

将下面代码补全提交即可

```c++
#include"ListNode.hpp"

class Solution {
    public:
        ListNode* swapPairs(ListNode* head) {
            if (head == nullptr || head->next == nullptr) {
                return head;
            }
            ListNode* newHead = head->next;
/*
在这补全代码
*/
            return newHead;
        }
};
```

