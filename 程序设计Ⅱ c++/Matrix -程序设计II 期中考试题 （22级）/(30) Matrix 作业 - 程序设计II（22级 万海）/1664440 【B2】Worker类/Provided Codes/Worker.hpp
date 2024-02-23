#ifndef WORKER_HPP
#define WORKER_HPP
class Worker
{
public:
    Worker(int id);
    ~Worker();
    int getId();
    static int getNumberOfObjects(); 
 
private:
    int id;
    static int numberOfObjects; //count the number of Student objects
};

#endif