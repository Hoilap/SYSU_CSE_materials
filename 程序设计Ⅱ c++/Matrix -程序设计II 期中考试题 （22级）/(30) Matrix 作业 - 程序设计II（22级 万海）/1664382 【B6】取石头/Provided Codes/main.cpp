#include "AI_550W.h"
#include "myAI.h"
#include <iostream>
using namespace std;


int main(){
	myAI ai1;
	AI_550W MOSS;
	// AI_stupid MOSS;

	int mission_steps_to_finish[4],record[4];
	for(int i=0;i<4;i++){
		cin>>mission_steps_to_finish[i];
	}
	int salt;
	cin>>salt;
	int hash_num=MOSS.simple_hash(mission_steps_to_finish,salt);

	//选择谁先手
	int token;
	if(ai1.chose_act_first(mission_steps_to_finish)){
		token=0;//ai1
	}else{
		token=1;
	}

	//开始游戏
	while(1){
		int mission_idx,step;
		for(int i=0;i<4;i++){
			record[i]=mission_steps_to_finish[i];
			// cout<<record[i]<<" ";
		}
		// cout<<endl;
		//选择动作
		if(token==0){
			ai1.action((const int*)mission_steps_to_finish,mission_idx,step);
		}else{
			MOSS.action((const int*)mission_steps_to_finish,mission_idx,step);
		}

		//检查合法性
		if(step<=0 || step>mission_steps_to_finish[mission_idx]){
			cout<<"Number out of range error."<<endl;
			return 0;
		}
		for(int i=0;i<4;i++){
			if(record[i]!=mission_steps_to_finish[i]){
				cout<<"Oh! You are smart but this is not going to work.."<<endl;
				cout<<"Maybe ask GZtime (no one knows CTF better than him) for help to hack this program later?"<<endl;
				return 0;
			}
		}
		//检查是否结束
		mission_steps_to_finish[mission_idx]-=step;
		int win_flag=1;
		// if(token==0){
		// 	cout<<"ai1 take "<<step<<" from "<<mission_idx<<endl;
		// }else{
		// 	cout<<"MOSS take "<<step<<" from "<<mission_idx<<endl;
		// }
		for(int i=0;i<4;i++){
			if(mission_steps_to_finish[i]!=0)win_flag=0;
		}
		if(win_flag){
			break;
		}
		token=(token+1)%2;
	}
	if(token==0){
		cout<<"You are the winner!"<<endl;
	}else{
		cout<<"You are the loser..."<<endl;
	}
	cout<<hash_num<<endl;
	return 0;
}


/*
class AI_stupid{
	public:
		AI_stupid(){}
		bool chose_act_first(const int arr[]){
			return true;
		}
		void action(const int arr[],int& mission_idx,int& step){
			for(int i=0;i<4;i++){
				if(arr[i]!=0){
					mission_idx=i;
					step=arr[i];
					return;
				}
			}
		}
};
*/