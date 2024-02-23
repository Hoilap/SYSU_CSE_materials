#include<iostream>
using namespace std;
#define LEN 10005
// f(x)= f(x-1)*g(x-2)+f(x-2)*g(x-1) % 10007
// g(x) = f(x/2)*g(x-1) % 10007

int f_res[LEN];
int g_res[LEN];
int fun_g(int x);
int fun_f(int x){
	if(x<10){
		return 1;
	}
	if(f_res[x]!=-1){
		return f_res[x];
	}
	return f_res[x]=(fun_f(x-1)*fun_g(x-2)+fun_f(x-2)*fun_g(x-1))%10007;
}
int fun_g(int x){
	if(x<10){
		return 1;
	}
	if(g_res[x]!=-1){
		return g_res[x];
	}
	return g_res[x]=(fun_f(x/2)*fun_g(x-1))%10007;
}
//����
int f(int x){
	int f_res[LEN];
	int g_res[LEN];
	for(int i=0;i<10;i++){
		f_res[i]=g_res[i]=1;
	}
	for(int i=10;i<=x;i++){
		f_res[i]=(f_res[i-1]*g_res[i-2]+f_res[i-2]*g_res[i-1])%10007;
		g_res[i]=(f_res[i/2]*g_res[i-1])%10007;
	}
	return f_res[x];
} 
int main(){
	int n;
	cin>>n;
	for(int i=0;i<=n;i++){
		f_res[i]=g_res[i]=-1;
	}
//	cout<<fun_f(n)<<endl;
	cout<<f(n)<<endl;
//	for(int i=0;i<n;i++){
//		cout<<"i"<<i<<" "<<f_res[i]<<endl;
//	}
}
