#include "FigureManager.h"

using namespace RNNSimulator;

FigureManager::FigureManager()
	: ObjectManager()
{
	nextId = -1;
	setDefault();
}


FigureManager::~FigureManager()
{
}

int FigureManager::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	setDefault();
	for (int i = 0;i < argvnum;i++) {
		std::string tmp = argvstr.at(i);
	}
	reset();
}

void FigureManager::reset() {
	if (nextId == -1)
		nextId += 1;
	colorSetNum = colorSet.size();
}

void FigureManager::setDefault() {
	colorSet = { "blue", "green", "red", "cyan", "magenta", "yellow", "black", "white" };
}

ObjectManager* FigureManager::getObject() {
	FigureManager* ret = (FigureManager*)ObjectManager::findObject("FigureManager");
	if (ret == NULL)
		ret = new FigureManager();
	return ret;
}

int FigureManager::getId(FigureViewer* obj)
{
	FigureManager* m = (FigureManager*)	FigureManager::getObject();
	int id = m->nextId;
	m->id.push_back(obj);
	m->nextId += 1;
}