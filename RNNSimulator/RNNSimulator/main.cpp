#include "MyInclude.h"

int main(void) {
	//	DebugMain::ConsoleTest();
	// 	DebugMain::OMTest();
	// 	DebugMain::OITest();
	//	DebugMain::ConnectableTest();
	// 	DebugMain::ConnectableNodeTest();
	//  DebugMain::GnuplotTest();

	DebugConsole::OpenConsole();

	RNNSimulator::FigureViewer* sample1 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample1->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample2 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample2->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample3 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample3->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample4 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample4->id  << ", nextId: " << sample1->nextId << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
	return 0;
};