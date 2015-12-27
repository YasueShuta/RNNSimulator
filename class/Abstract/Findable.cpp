#include "Findable.h"
#include <typeinfo.h>

#ifndef _FINDABLE_CPP
#define _FINDABLE_CPP
RNNSimulator::Findable* RNNSimulator::Findable::ROOT = NULL;
int RNNSimulator::Findable::NEXTID = 0;
//RNNSimulator::SampleFindable* RNNSimulator::SampleFindable::ROOT = NULL;
//t RNNSimulator::SampleFindable::NEXTID = 0;
#endif

using namespace RNNSimulator;

Findable::Findable()
{
	id = NEXTID;
	NEXTID++;
	this->next = ROOT;
	ROOT = this;
}

Findable::~Findable()
{
	//	std::cout << "Destructor: parent" << std::endl;
	Findable* parent;
	parent = (Findable*)findObject<>(id + 1);
	parent->next = this->next;
}