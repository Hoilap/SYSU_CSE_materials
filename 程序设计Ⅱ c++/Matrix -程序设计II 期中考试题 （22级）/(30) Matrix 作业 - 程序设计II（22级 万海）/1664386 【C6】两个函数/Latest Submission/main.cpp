#include <iostream>
#include <cmath>
#include <vector>
using namespace std;
vector<long long> f(10,1);
vector<long long> g(10,1);
int xf=10;
int xg=10;

void f_fun(){
    f.push_back((f[xf-1]*g[xf-2]+f[xf-2]*g[xf-1])%10007);
    xf++;
}
void g_fun(){
    g.push_back(f[xg/2]*g[xg-1]%10007);
    xg++;
}
int main(){
    int n;
    cin>>n;
    // for(auto it=f.begin();it!=f.end();it++){
    //     cout<<*it<<endl;
    // }
    while(n>xf){
        if(xf-2<g.size())  f_fun();
        if(xg/2<f.size())  g_fun();    
    }
    // for(auto it=f.begin();it!=f.end();it++){
    //     cout<<*it<<" ";
    // }
    // cout<<endl;
    // for(auto it=g.begin();it!=g.end();it++){
    //     cout<<*it<<" ";
    // }
    cout<<f[n]%10007<<endl;
}