#include"ListNode.h"
using namespace std;
//迭代法
ListNode* reverseList(ListNode* head) {
    ListNode* temp; // 保存cur的下一个节点
    ListNode* cur = head;
    ListNode* pre = NULL;
    while(cur) {
        ListNode* pre_temp = pre;
        int flag = 0;
        while(pre_temp){
            if(pre_temp->val==cur->val){
                flag=1;
                pre_temp = pre_temp;
                cur = cur->next;
                break;
            }
            pre_temp = pre_temp->next;
        }
        if(flag ==1) continue;
        temp = cur->next;  // 保存一下 cur的下一个节点，因为接下来要改变cur->next
        cur->next = pre; // 翻转操作
        // 更新pre 和 cur指针
        pre = cur;
        cur = temp;
    }
    return pre;
}
//递归法 仅供参考
/*
ListNode* reverseList(ListNode* head) {
        // 边缘条件判断
        if(head == NULL) return NULL;
        if (head->next == NULL) return head;
        
        // 递归调用，翻转第二个节点开始往后的链表
        ListNode *last = reverseList(head->next);
        // 翻转头节点与第二个节点的指向
        head->next->next = head;
        // 此时的 head 节点为尾节点，next 需要指向 NULL
        head->next = NULL;
        return last;
}
 */
