#include"myAI.h"

myAI::myAI(){
	
}

bool myAI::chose_act_first(const int arr[]){
//选择是否先手
	int* narr=const_cast<int*>(arr);
	int win_flag=get_action(narr);
	if(win_flag==1){
		return true;
	}else{
		return false;
	}

}
//选择动作 
void myAI::action(const int arr[],int& mission_idx,int& step){
	// int a=arr[0],b=arr[1],c=arr[2],d=arr[3];
	// int win_flag=get_action(a,b,c,d);
	int* narr=const_cast<int*>(arr);
	int win_flag=get_action(narr);

	if(win_flag==1){
		int a=arr[0],b=arr[1],c=arr[2],d=arr[3];
		mission_idx=move[a][b][c][d].first;
		step=move[a][b][c][d].second;
	}else{
		for(int i=0;i<4;i++){
			if(arr[i]!=0){
				mission_idx=i;
				step=arr[i];
			}
		}
	}
}

int myAI::get_action(int arr[]){
	int a=arr[0],b=arr[1],c=arr[2],d=arr[3];
	if(a==0 && b==0 && c==0 && d==0)return -1;
	if(dp[a][b][c][d]!=0)return dp[a][b][c][d];
	
	//若有一个下法使得下一个局面先手输则 suc
	pair<int,int> max_move(0,0);
	int suc_flag=-1;
	for(int move_idx=0;move_idx<4;move_idx++){//枚举拿每个堆 
		int t=arr[move_idx];
		for(int i=0;i<t;i++){//枚举拿的数量 
			arr[move_idx]=i;
			if(get_action(arr)==-1){
				suc_flag=1;
				if(t-i>max_move.second){//拿的数量多就看这个 
					max_move=make_pair(move_idx,t-i);
				}
			}
		}
		arr[move_idx]=t;
	}
	move[a][b][c][d]=max_move;
	return dp[a][b][c][d]=suc_flag;
}

int myAI::get_action(int a,int b,int c,int d){
	if(a==0 && b==0 && c==0 && d==0)return -1;
	if(dp[a][b][c][d]!=0)return dp[a][b][c][d];
	//若有一个下法使得下一个局面先手输则 suc
	pair<int,int> max_move(0,0);
	int suc_flag=-1;
	int arr[4]={a,b,c,d};
	int change_arr[4]={0};
	for(int move_idx=0;move_idx<4;move_idx++){//枚举拿每个堆 
		for(int i=0;i<arr[move_idx];i++){//枚举拿的数量 
			if(get_action((move_idx==0?i:a),(move_idx==1?i:b),(move_idx==2?i:c),(move_idx==3?i:d))==-1){
				suc_flag=1;
				if(arr[move_idx]-i>max_move.second){//拿的数量多就看这个 
					max_move=make_pair(move_idx,arr[move_idx]-i);
				}
			}
		}
	}
	move[a][b][c][d]=max_move;
	return dp[a][b][c][d]=suc_flag;
}
