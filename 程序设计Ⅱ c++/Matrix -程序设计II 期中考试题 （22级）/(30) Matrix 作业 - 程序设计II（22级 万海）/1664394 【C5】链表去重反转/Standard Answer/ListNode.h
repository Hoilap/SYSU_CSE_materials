#ifndef LISTNODE_H
#define LISTNODE_H

#include<iostream>

class ListNode{
public:
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
    
};

#endif 
