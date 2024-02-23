#ifndef __FRIENDS__
#define __FRIENDS__

#include<string>
#include<iostream>
using namespace std;


class FriendsFinder{
    public:
    string persons[10];
    string friends[10][10];
    FriendsFinder(string persons[],string friends[][10]){
        for(int i=0;i<10;i++){
            this->persons[i]=persons[i];
            for(int j=0;j<10;j++){
                this->friends[i][j]=friends[i][j];
            }
        }
    }
    void operator()();
};
#endif