#include<iostream>
using namespace std;


class Node{
    public:
    int i;
    int tf;
};
int N;
int status[N]={-1};
int f(int n){
    if(status[arr[n].i]!=-1){//能够调查之前落实的元素
        if(arr[n].tf!=status[n])  //矛盾
        else status[n]=arr[n].tf;
    }
    else status[n]=arr[n].tf;
    if(n<N) f(n+1);
}

int main(){
    cin>>N;
    Node arr[N];
    for(int p=0;p<N;p++){
        cin>>arr[p].i;
        cin>>arr[p].tf;
    }
    f(0);
}