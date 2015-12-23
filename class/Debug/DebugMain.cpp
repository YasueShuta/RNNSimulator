#include <iostream>
#include <string>

#include "DebugMain.h"
#include "DebugConsole.h"
#include "../Abstract/ObjectManager.h"
#include "../Abstract/ObjectInitializer.h"


DebugMain::DebugMain()
{
}


DebugMain::~DebugMain()
{
}

int DebugMain::Main()
{
	return 0;
}

int DebugMain::ConsoleTest()
{
	DebugConsole::OpenConsole();

	std::cout << "Hello, World!" << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}

int DebugMain::OMTest()
{
	DebugConsole::OpenConsole();

	std::cout << "Start:" << std::endl;
	std::cout << "num: " << ObjectManagerStore::num << std::endl;
	ObjectManager* a = new ObjectManager();
	std::cout << "a: " << a << std::endl;
	std::cout << "num: " << ObjectManagerStore::num << std::endl;
	ObjectManager* b = new ObjectManager();
	std::cout << "b: " << b << std::endl;
	std::cout << "num: " << ObjectManagerStore::num << std::endl;
	ObjectManager* c = new SampleManager();
	std::cout << "c: " << c << std::endl;
	std::cout << "num: " << ObjectManagerStore::num << std::endl;
	ObjectManager* curr = ObjectManagerStore::root;
	for (int i = 0;i < ObjectManagerStore::num; i++) {
		std::cout << curr->parent << "->";
		curr = curr->parent;
	}
	std::cout << std::endl;
	delete b;
	curr = ObjectManagerStore::root;
	for (int i = 0;i < ObjectManagerStore::num; i++) {
		std::cout << curr->parent << "->";
		curr = curr->parent;
	}
	std::cout << std::endl;

	std::cout << "Type: " << typeid(*ObjectManagerStore::root->parent).name() << std::endl;
	std::cout << "Type: " << typeid(*a).name() << std::endl;
	std::cout << "Type: " << typeid(*c).name() << std::endl;

 ObjectManager* d = new ObjectManager();
 ObjectManager* e = new ObjectManager();
	ObjectManager* fo = ObjectManager::findObject("SampleManager");
	if (fo != NULL) {
		std::cout << "Find (SampleManager): " << fo << "|" << typeid(*fo).name() << std::endl;
	}
	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}

int DebugMain::OITest() {
	DebugConsole::OpenConsole();
	std::cout << "Start!" << std::endl;

	SampleInitializer^ sample = gcnew SampleInitializer();

	DebugConsole::Wait();
	sample->set("-n 128 -p 0.001 threshold 1");

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}