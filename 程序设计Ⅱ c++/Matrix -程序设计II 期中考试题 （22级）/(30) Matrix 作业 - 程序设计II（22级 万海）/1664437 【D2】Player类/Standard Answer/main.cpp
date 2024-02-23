#include <iostream>
#include "Player.hpp"
using namespace std;

void displayStudent(Player &worker1, Player &worker2)
{
    cout << "worker1 id: " << worker1.getId() << endl;
    cout << "worker2 id: " << worker2.getId() << endl;
}

int main()
{
    int id;
    cin >> id;
    Player worker1(id);
    cout << "number of Player objects: " << Player::getNumberOfObjects() << endl;

    Player worker2(id);
    cout << "number of Player objects: " << Player::getNumberOfObjects() << endl;

    cout << "After creating worker1 and worker2" << endl;
    displayStudent(worker1, worker2);
    {
        Player worker3(id); 
        cout << "number of Player objects: " << Player::getNumberOfObjects() << endl;
    }
    cout << "number of Player objects: " << Player::getNumberOfObjects() << endl;

    
    return 0;
}
