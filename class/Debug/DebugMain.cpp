#include <iostream>
#include <string>

#define _USE_MATH_DEFINES
#include <math.h>

#include "DebugMain.h"
#include "DebugConsole.h"
#include "../Abstract/Findable.h"
#include "../Abstract/ObjectInitializer.h"
#include "../Connector/Connectable.h"
#include "../Connector/Connector.h"
#include "../Connector/ConnectableNode.h"
#include "../Figure/FigureViewer.h"
#include "../gnuplotInterface/Gnuplot.h"

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

int DebugMain::FindableTest()
{
	DebugConsole::OpenConsole();

	std::cout << "Start:" << std::endl;
	RNNSimulator::Findable* tmp;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp = new RNNSimulator::Findable();
	std::cout << "a: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp  = new RNNSimulator::Findable();
	std::cout << "b: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp = new RNNSimulator::SampleFindable();
	std::cout << "c: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp = new RNNSimulator::SampleFindable();
	std::cout << "d: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp = new RNNSimulator::Findable();
	std::cout << "e: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;
	tmp = new RNNSimulator::SampleFindable();
	std::cout << "f: " << tmp << std::endl;
	std::cout << "num: " << RNNSimulator::Findable::NEXTID << std::endl;

	RNNSimulator::Findable* curr;

	/*
	std::cout << "Findable" << std::endl;

	curr = RNNSimulator::Findable::ROOT;
	for (int i = 0;i < RNNSimulator::Findable::NEXTID; i++) {
		std::cout << curr << "->";
		curr = curr->next;
	}
	std::cout << std::endl;
	*/
	/*
	std::cout << "find id=1" << std::endl;
	curr = (RNNSimulator::Findable*)RNNSimulator::findObject<>(1);
	std::cout << curr << std::endl;

	std::cout << "find T=SampleFindable" << std::endl;
	curr = (RNNSimulator::SampleFindable*)RNNSimulator::findObject<RNNSimulator::SampleFindable>();
	std::cout << curr << std::endl;

	std::cout << "find id=2" << std::endl;
	curr = (RNNSimulator::SampleFindable*)RNNSimulator::findObject<>(2);
	std::cout << curr << std::endl;
	*/
	curr = (RNNSimulator::Findable*)RNNSimulator::findObject<>(1);
	std::cout << "Delete: " << curr << std::endl;
	delete curr;
	curr = (RNNSimulator::Findable*)RNNSimulator::findObject<RNNSimulator::SampleFindable>(3);
	std::cout << "Delete: " << curr << std::endl;
	delete curr;

	curr = RNNSimulator::Findable::ROOT;
	for (int i = 0;i < RNNSimulator::Findable::NEXTID; i++) {
		std::cout << curr << "->";
		if (curr == NULL) break;
		curr = curr->next;
	}
	std::cout << std::endl;
	
	/*
	std::cout << "Type: " << typeid(*RNNSimulator::Findable::ROOT->next).name() << std::endl;
	std::cout << "Type: " << typeid(*a).name() << std::endl;
	std::cout << "Type: " << typeid(*c).name() << std::endl;
	*/

	RNNSimulator::Findable* fo = (RNNSimulator::Findable*)RNNSimulator::findObject<RNNSimulator::SampleFindable>();
	if (fo != NULL) {
		std::cout << "Find (SampleFindable): " << fo << "| " << fo->id << "| " << typeid(*fo).name() << std::endl;
	}

	std::cout << RNNSimulator::Findable::NEXTID << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}

int DebugMain::OITest() {
	DebugConsole::OpenConsole();
	std::cout << "Start!" << std::endl;

	RNNSimulator::SampleInitializer* sample = new RNNSimulator::SampleInitializer();

	std::cout << "id: " << sample->id << std::endl <<
		"name: " << sample->name << std::endl <<
		"data: " << sample->data << std::endl;
	DebugConsole::Wait();

	sample->set("-id 128 -name trouble, threshold, 1, data 2.345");

	sample->setvar(4, "id", 64, "name", "va", "data", 0.5f, "ptr", &sample);

	DebugConsole::Wait();
	std::cout << "id: " << sample->id << std::endl <<
		"name: " << sample->name << std::endl <<
		"data: " << sample->data << std::endl <<
		"ptr: " << sample->ptr << std::endl;
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

int DebugMain::FigureViewerTest() {

	DebugConsole::OpenConsole();

	RNNSimulator::FigureViewer* sample1 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample1->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample2 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample2->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample3 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample3->id << ", nextId: " << sample1->nextId << std::endl;
	RNNSimulator::FigureViewer* sample4 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample4->id << ", nextId: " << sample1->nextId << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}


int DebugMain::GnuplotTest() {

	// Initialize
	Gnuplot::GP* gp1 = new Gnuplot::GP();

	Gnuplot::Handle* h2 = new Gnuplot::Handle();
	Gnuplot::GP* gp2 = new Gnuplot::GP(h2);

	Gnuplot::Handle* h3 = new Gnuplot::Handle();
	int id3 = h3->id;
	Gnuplot::GP* gp3 = new Gnuplot::GP(id3);

	Gnuplot::GP* gp4_ = new Gnuplot::GP();
	int id4 = gp4_->getId();
	delete gp4_;
	Gnuplot::GP* gp4 = new Gnuplot::GP(id4);

	// set stdout, stdin
	DebugConsole::OpenConsole();

	// set window position
	gp1->hwrite("set terminal windows position 30,30 title 'function'");
	gp2->hwrite("set terminal windows position 700,30 title 'vector");
	gp3->hwrite("set terminal windows position 30,460 title 'vector multi'");
	gp4->hwrite("set terminal windows position 700,460 title 'vector multi'");

	// make function
	int num = 1000; double dx = 4*M_PI/num;
	std::vector<double> xvec(num);
	std::vector<double> yvec1(num);
	std::vector<double> yvec2(num);
	for (int i = 0;i < num;i++) {
		xvec.at(i) = dx*i - 2 * M_PI;
		yvec1.at(i) = sin(xvec.at(i));
		yvec2.at(i) = cos(xvec.at(i));
	}
	double* xptr = &xvec.at(0);
	double* yptr1 = &yvec1.at(0);
	double* yptr2 = &yvec2.at(0);

	// plot
	gp1->hwrite("set xrange [-2*pi:2*pi]");
	gp1->hwrite("set yrange [-2:2]");

	gp1->hwrite("plot sin(x) lw 3 lc 'blue'");
	gp1->hwrite("replot cos(x) lw 3 lc 'green'");
	gp1->hwrite("replot tan(x) lw 3 lc 'red'");
	gp1->hwrite("replot tanh(x) lw 3 lc 'yellow'");

	std::stringstream ss;
	ss << "set xrange [" << xvec.at(0) << ":" << xvec.at(xvec.size() - 1) << "]" << std::endl;
	ss << "set xlabel 'time'" << std::endl;
	ss << "set ylabel 'value'";
	gp2->hwrite(ss.str());
	gp2->plotVec2(xvec, yvec1, "with lines linewidth 3 linecolor 'orange' title \"sin(x)\"");

	std::vector<std::vector<double>> yvecarray{yvec1, yvec2};
	std::vector<const char*> optionarray{ "with lines lw 3 lc 'cyan' title 'sin(x)'", "with lines lw 3 lc 'magenta' title 'cos(x)'"};
	double* yptrarray[2] = { yptr1, yptr2 };
	const char* optptrarray[2] = { "with lines lw 3 lc 'cyan' title 'sin(x)'", "with lines lw 3 lc 'magenta' title 'cos(x)'" };

	gp3->hwrite(ss.str());
	gp3->plotVec2Multi(xvec, yvecarray, optionarray);

	gp4->hwrite(ss.str());
	gp4->plotVec2Multi(xptr, num, yptrarray, 2, optptrarray);

	/*
	std::string buf;

	while (1) {
		buf = DebugConsole::GetLine();
		if (buf.compare("quit") == 0) {
			break;
		}
		std::cout << buf << std::endl;
		gp1->hwrite(buf);
		//h->dispBuf();
	}
	*/

	
	DebugConsole::Wait();

	Gnuplot::GP::replotAll();
	

	Gnuplot::Handle* curr = Gnuplot::Handle::HEAD;
	while (curr != NULL) {
		std::cout << "curr: " << curr << " next: " << curr->nextHandle << std::endl;
		curr = curr->nextHandle;
	}

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}