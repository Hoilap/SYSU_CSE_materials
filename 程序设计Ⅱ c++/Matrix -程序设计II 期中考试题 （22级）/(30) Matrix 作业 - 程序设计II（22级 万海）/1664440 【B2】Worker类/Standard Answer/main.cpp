#include <iostream>
#include "Worker.hpp"
using namespace std;

void displayStudent(Worker &worker1, Worker &worker2)
{
    cout << "worker1 id: " << worker1.getId() << endl;
    cout << "worker2 id: " << worker2.getId() << endl;
}

int main()
{
    int id;
    cin >> id;
    Worker worker1(id);
    cout << "number of Worker objects: " << Worker::getNumberOfObjects() << endl;

    Worker worker2(id);
    cout << "number of Worker objects: " << Worker::getNumberOfObjects() << endl;

    cout << "After creating worker1 and worker2" << endl;
    displayStudent(worker1, worker2);
    {
        Worker worker3(id); 
        cout << "number of Worker objects: " << Worker::getNumberOfObjects() << endl;
    }
    cout << "number of Worker objects: " << Worker::getNumberOfObjects() << endl;

    
    return 0;
}
