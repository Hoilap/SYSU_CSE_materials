#include <iostream>
#include "Worker.hpp"

using namespace std;


Worker::Worker(int Id) 
{
	id = Id;
	numberOfObjects++;
}

Worker::~Worker() 
{
	numberOfObjects--;
}


int Worker::getId() 
{
	return id;
}


int Worker::getNumberOfObjects() 
{
	return numberOfObjects;
}

int Worker::numberOfObjects = 0;