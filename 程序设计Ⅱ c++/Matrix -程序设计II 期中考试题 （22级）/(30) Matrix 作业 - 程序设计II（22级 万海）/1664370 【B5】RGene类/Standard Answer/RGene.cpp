#include "RGene.hpp"
#include <iostream>
using namespace std;

RGene::RGene(const baseR* seq_, int num_){
    if (seq_ && (num_>0)) {
        num=num_;
        seq = new baseR[num];
        for (int i = 0; i < num; i++)
            seq[i]=seq_[i];
    }
    else {
        seq=nullptr;
        num=0;
    }
}

RGene::RGene(const RGene& R){
    num=R.num;
    if (R.seq) {
        seq = new baseR[num];
        for (int i = 0; i < num; i++)
            seq[i]=R.seq[i];
    }
    else
        seq=nullptr;
}

RGene RGene::trans() const
{
    RGene result;
    if(seq && (num>0))
    {
        result.num=num;
        result.seq=new baseR[num];
        for (int i = 0; i < num; i++)
        {
            switch (seq[i])
            {
            case A:result.seq[i]=U;break;
            case U:result.seq[i]=A;break;
            case C:result.seq[i]=G;break;
            case G:result.seq[i]=C;break;
            default: break;
            }
        }
    }
    return result;
}

void RGene::printSeq()const
{
    if (num>0)
    {
        for (int i = 0; i < num; i++)
        {
            switch (seq[i])
            {
            case A:cout<<'A';break;
            case G:cout<<'G';break;
            case C:cout<<'C';break;
            case U:cout<<'U';break;
            default: break;
            }
        }
        cout<<endl;
    }
    else
        cout<<"empty data"<<endl;
}

RGene::~RGene(){delete []seq; seq=nullptr; num=0;}