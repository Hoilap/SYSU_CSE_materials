#include <iostream>
#include "Player.hpp"

using namespace std;


Player::Player(int Id) 
{
	id = Id;
	numberOfObjects++;
}

Player::~Player() 
{
	numberOfObjects--;
}


int Player::getId() 
{
	return id;
}


int Player::getNumberOfObjects() 
{
	return numberOfObjects;
}

int Player::numberOfObjects = 0;