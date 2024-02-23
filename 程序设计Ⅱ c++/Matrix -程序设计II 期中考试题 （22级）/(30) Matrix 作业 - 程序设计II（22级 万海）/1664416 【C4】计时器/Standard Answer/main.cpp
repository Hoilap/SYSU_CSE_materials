#include "timer.hpp"

int main()
{
        int hr, min;
        cin>>hr>>min;
        Timer ob=Timer(hr,min);
        
        ob++;
        ob.print();
        ob--;
        ob--; 
        ob.print();
        return 0;
}