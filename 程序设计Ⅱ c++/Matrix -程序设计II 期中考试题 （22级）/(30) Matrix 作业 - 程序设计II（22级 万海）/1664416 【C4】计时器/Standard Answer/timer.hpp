#include<iostream>
using namespace std;

class Timer
{
        int hr, min;
     public:
        Timer(const int h=0, const int m=0){
                hr=h;
                min=m;
        }
        
        void operator++(int);
        void operator--(int);
        void print(){
                cout<<hr<<" "<<min<<endl;
        }
};