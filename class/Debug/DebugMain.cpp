#include <iostream>
#include <string>

#include "DebugMain.h"
#include "DebugConsole.h"
#include "../Abstract/ObjectManager.h"
#include "../Abstract/ObjectInitializer.h"
#include "../Connector/Connectable.h"
#include "../Connector/Connector.h"
#include "../Connector/ConnectableNode.h"

#include "../../RNNSimulator/RNNSimulator/MyPath.h"


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

int DebugMain::ConnectableTest() {
	DebugConsole::OpenConsole();
	std::cout << "Start!" << std::endl;

	RNNSimulator::Connectable* sample = new RNNSimulator::SampleConnectable(3, 5);
	std::cout << "in: " << sample->inflow_len() << std::endl;
	std::cout << "out: " << sample->outflow_len() << std::endl;

	RNNSimulator::Connector* con = new RNNSimulator::Connector(sample, sample, 1);
	std::cout << "weight" << std::endl;
	std::cout << con->weight << std::endl;

	std::cout << "flowIn: " << std::endl;
	std::cout << sample->outflow() << std::endl;
	std::cout << "flowOut: " << std::endl;
	std::cout << con->transmit(1) << std::endl;
	sample->inflow(con->transmit(1));
 
	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}

int DebugMain::ConnectableNodeTest() {
	DebugConsole::OpenConsole();
	std::cout << "Start!" << std::endl;

	RNNSimulator::ConnectableNode* sample = new RNNSimulator::ConnectableNode(5);
	std::cout << "n: " << sample->cellNum << std::endl;
	std::cout << "x: " << sample->potential << std::endl;
	std::cout << "r: " << sample->readout << std::endl;

	RNNSimulator::Connector* con = new RNNSimulator::Connector(sample, sample, 1);
	std::cout << "weight" << std::endl;
	std::cout << con->weight << std::endl;

	std::cout << "flowIn: " << std::endl;
	std::cout << sample->outflow() << std::endl;
	std::cout << "flowOut: " << std::endl;
	std::cout << con->transmit(1) << std::endl;
	sample->inflow(con->transmit(1));

	std::cout << "x: " << sample->potential << std::endl;
	std::cout << "r: " << sample->readout << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}


int DebugMain::GnuplotTest() {
	DebugConsole::OpenConsole();

	FILE *fp = _popen(MyPath::GNUPLOT_PATH(), "w");
	std::stringstream ss;
	ss << "plot sin(x)" << std::endl;
	fputs(ss.str().c_str(), fp);
	fflush(fp);

	std::cout << ss.str() << std::endl;

	DebugConsole::Wait();
	_pclose(fp);
	DebugConsole::CloseConsole();

	return 0;
}