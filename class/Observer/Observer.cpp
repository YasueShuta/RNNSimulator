#include "Observer.h"

using namespace RNNSimulator;

#ifndef _RNN_Observer_CPP
#define _RNN_Observer_CPP
Observer* Observer::HEAD = NULL;
int Observer::NEXTID = 0;
#endif


Observer::Observer()
{
	setId();
}


Observer::~Observer()
{
	Observer* curr = Observer::HEAD;
	if (curr == this) {
		Observer::HEAD = nextObserver;
		curr = NULL;
	}
	while (curr != NULL) {
		if (curr->nextObserver == this) {
			curr->nextObserver = nextObserver;
			break;
		}
		curr = curr->nextObserver;
	}
}


void Observer::setId() {
	id = Observer::NEXTID;
	Observer::NEXTID += 1;
	nextObserver = Observer::HEAD;
	Observer::HEAD = this;
}
int Observer::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	for (int i = 0;i < argvnum; i++) {
		std::string tmp = argvstr.at(i);
		if (tmp.compare("target") == 0 || tmp.compare("t")) {
//			target = argvdata
		}
	}
	return 0;
}