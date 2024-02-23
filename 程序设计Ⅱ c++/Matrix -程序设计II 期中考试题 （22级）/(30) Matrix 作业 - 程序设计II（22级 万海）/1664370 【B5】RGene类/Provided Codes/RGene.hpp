#ifndef _RGene_HPP_
#define _RGene_HPP_

enum baseR {A, G, C, U};  //RNA碱基

class RGene
{
private:
    baseR* seq;  //碱基序列
    int num;  //碱基数量
public:
    RGene(const baseR* seq_=nullptr, int num_=0); //构造函数
    RGene(const RGene& other);  //拷贝构造函数
    RGene trans()const;  //RNA转录
    void printSeq() const;  //打印RNA序列信息
    ~RGene();  //析构函数

    RGene& operator=(const RGene&)=delete; //不调用，不需要实现
};

#endif