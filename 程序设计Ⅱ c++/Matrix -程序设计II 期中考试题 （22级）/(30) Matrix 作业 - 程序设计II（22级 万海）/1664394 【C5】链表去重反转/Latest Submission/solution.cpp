#include<iostream>
#include<vector>
#include"ListNode.h"
using namespace std;
ListNode* reverseList(ListNode* head){
    vector<int> arr;
    ListNode *p=head;
    while(p!=NULL){
        int issame=0;
        for(auto it=arr.begin();it!=arr.end();it++){
            if(*it==p->val) {
                issame=1;
                break;
            }
            else continue;
        }
        if(issame==0) arr.push_back(p->val);
        p=p->next;
    }
    // for(auto it=arr.begin();it!=arr.end();it++){
    //    cout<<*it<<" ";
    // }
    ListNode *ans=new ListNode(0);
    ListNode *p2=ans;
    for(auto it=arr.rbegin();it!=arr.rend();it++){
        p2->val=*it;
        if(it!=arr.rend()-1) p2->next=new ListNode(0);   
        else p2->next=NULL;
        p2=p2->next;   
    }

    return ans;
}
