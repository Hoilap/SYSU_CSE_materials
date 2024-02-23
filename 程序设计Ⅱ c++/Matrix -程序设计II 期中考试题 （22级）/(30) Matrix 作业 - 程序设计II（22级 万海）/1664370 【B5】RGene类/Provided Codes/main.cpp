#include <iostream>
#include "RGene.hpp"
using namespace std;

void s2RNA(string s, baseR* r){
    for (int i = 0; i < s.length(); i++)
    {
        switch (s[i])
        {
        case 'A':r[i]=A;break;
        case 'G':r[i]=G;break;
        case 'C':r[i]=C;break;
        case 'U':r[i]=U;break;
        default: r[i]=U;break;
        }
    }
}

int main()
{
    int m,n;
    cin>>m>>n;  //题目样例输入保证长度一致
    string s1,s2;
    cin>>s1>>s2;
    baseR* bSeq[2]{};
    if (m>0)
    {
        bSeq[0]=new baseR[m];
        s2RNA(s1,bSeq[0]);
    }
    if (n>0)
    {
        bSeq[1]=new baseR[n];
        s2RNA(s2,bSeq[1]);
    }

    RGene* v1=new RGene(bSeq[1],n);
    RGene v2(*v1);
    delete v1;
    v1=new RGene(bSeq[0],m);
    cout<<"RNA sequence v1:"<<endl;
    v1->printSeq();
    delete v1;
    cout<<"RNA sequence v2:"<<endl;
    v2.printSeq();

    delete []bSeq[0];
    delete []bSeq[1];

    RGene mRNA(v2.trans());
    cout<<"RNA sequence v2 is transcribed into:"<<endl;
    mRNA.printSeq();

    return 0;
}