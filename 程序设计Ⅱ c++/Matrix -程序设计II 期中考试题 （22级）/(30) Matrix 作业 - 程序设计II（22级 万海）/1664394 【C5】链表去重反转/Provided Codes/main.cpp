#include<iostream>
#include"ListNode.h"
using namespace std;
extern ListNode* reverseList(ListNode* head);
int main(){
    int n;
    cin>>n;
    ListNode* head=new ListNode(0);
    ListNode* cur=head;
    while(n>0){
        int temp;
        cin>>temp;
        ListNode* node=new ListNode(temp);
        cur->next=node;
        cur=cur->next;
        n--;
    }
    ListNode* res=reverseList(head->next);
    while(res!=nullptr){
        cout<<res->val<<" ";
        res=res->next;
    }
    return 0;
}