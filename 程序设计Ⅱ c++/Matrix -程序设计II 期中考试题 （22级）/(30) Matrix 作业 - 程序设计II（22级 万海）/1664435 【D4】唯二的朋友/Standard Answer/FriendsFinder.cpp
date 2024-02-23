#include<iostream>
#include "FriendsFinder.hpp"

using namespace std;

void FriendsFinder::operator()(){
    string output[100];
    int cnt=0;
    for(int i=0;i<10;i++){//for each person
        for(int j=0;j<10;j++){// for each of his friend
            int f_cnt=1;
            for(int k=0;k<100;k++){// for each of friend other people

                if(k/10==i)continue;
                if(friends[k/10][k%10]==friends[i][j]){
                    f_cnt++;
                    if (f_cnt==3)break;

                }
            }
            if(f_cnt==2){//record it
                output[cnt]=friends[i][j];
                cnt++;
            }
        }
    }
    //bubble sort
    for(int i=0;i<cnt;i++){
        for(int j=0;j<cnt-i-1;j++){
            if(output[j]>output[j+1]){
                string t=output[j];
                output[j]=output[j+1];
                output[j+1]=t;
            }
        }
    }
    //output
    for(int i=0;i<cnt;i++){
        if(i%2==0){
            cout<<output[i]<<" ";
        }
    }
}