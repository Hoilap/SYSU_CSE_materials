#include"ListNode.hpp"

class Solution {
    public:
        ListNode* swapPairs(ListNode* head) {
            if (head == nullptr || head->next == nullptr) {
                return head;
            }
            ListNode* newHead = head->next;
            head->next = swapPairs(newHead->next);
            newHead->next = head;
            return newHead;
        }
};