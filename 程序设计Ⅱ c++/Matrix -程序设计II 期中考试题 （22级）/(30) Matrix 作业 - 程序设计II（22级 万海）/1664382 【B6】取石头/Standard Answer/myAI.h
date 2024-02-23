#ifndef MYAI_H
#define MYAI_H

#include<map>
using namespace std;

#define LEN 15
class myAI{

	public:
		myAI();
		bool chose_act_first(const int arr[]);//选择是否先手
		void action(const int arr[],int& mission_idx,int& step);//选择动作 
		
	private:
		int get_action(int a,int b,int c,int d);
		int get_action(int arr[]);
		int dp[LEN][LEN][LEN][LEN];// 剩余棋子数->先手赢则1 否则-1 
		pair<int,int> move[LEN][LEN][LEN][LEN]; // 剩余棋子数->先手赢时下的方法 
};


/*
#include<iostream>
#include<map>
using namespace std;

#define LEN 15
int dp[LEN][LEN][LEN][LEN];// 剩余棋子数->先手赢则1 否则-1 
pair<int,int> move[LEN][LEN][LEN][LEN]; // 剩余棋子数->先手赢时下的方法 

int fun(int arr[]){ //size of arr:4

}


int main(){
	int arr[4];
	for(int i=0;i<4;i++){
		cin>>arr[i];
	}
	int ans=fun(arr);
	printf("先手赢吗？%d\n",ans);
	pair<int,int> movement=move[arr[0]][arr[1]][arr[2]][arr[3]];
	printf("最优动作:取第%d堆的%d个石头\n",movement.first+1,movement.second);
//	while(1){
//
//	}
}


*/
#endif
