#include "myAI.h"
#include <iostream>
using namespace std;

bool myAI::chose_act_first(const int arr[]){
    if(arr[0]^arr[1]^arr[2]^arr[3]==0) {
        //cout<<"0";
        return 1;
    }
    else return 0;
}
void myAI::action(const int arr[],int& mission_idx,int& step){
    
    int i,j;
    for(i=0;i<4;i++){//mission_idx
        for(j=0;j<arr[i];j++){//step
            int t = arr[i] ^ arr[0]^arr[1]^arr[2]^arr[3];
            if (t < arr[i]) {
                mission_idx = i;
                step = arr[i] - t;
                return;
            }
        }
    }
    cout<<arr[0]<<" "<<arr[1]<<" "<<arr[2]<<" "<<arr[3]<<endl;
    cout<<mission_idx<<" "<<step<<endl;
}