#ifndef PLAYER_HPP
#define PLAYER_HPP
class Player
{
public:
    Player(int id);
    ~Player();
    int getId();
    static int getNumberOfObjects(); 
 
private:
    int id;
    static int numberOfObjects; //count the number of Student objects
};

#endif