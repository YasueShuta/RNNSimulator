#include <iostream>
#include <string>

#define _USE_MATH_DEFINES
#include <math.h>
#include <random>
#include <fstream>

#include "DebugMain.h"
#include "DebugConsole.h"
#include "../Abstract/Findable.h"
#include "../Abstract/ObjectInitializer.h"
#include "../Connector/Connectable.h"
#include "../Connector/Connector.h"
#include "../Connector/ConnectableNode.h"
#include "../Figure/FigureViewer.h"
#include "../Recorder/IdManager.h"
#include "../Recorder/DataRecorder.h"
#include "../RNN/RNNNode.h"
#include "../Observer/Observer.h"
#include "../Observer/TemporalObserver.h"
#include "../FORCE/RLSModule.h"
#include "../FORCE/FORCEModule.h"

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
	/*
	{
		std::ofstream ofs("test.txt");
		ofs << "Jast a Minute 5" << std::endl;
		ofs << "Input:    Answer5AnswerAnswer" << std::endl;
	}
	
	DebugConsole::OpenConsole();

	{
		std::ifstream ifs("test.txt");
		std::string str, mem;
		char buf[19];
		int b;
	
		std::getline(ifs, str);	
		std::cout << str << std::endl;
		sscanf_s(str.c_str(), "Jast a Minute %d", &b);
		std::cout << "b: " << b << std::endl;
		DebugConsole::Wait();

		ifs >> str;
		std::cout << str << " " << std::endl;
		ifs >> str;
		std::cout << str << std::endl;
		mem = str;
		std::cout << mem << std::endl;
		DebugConsole::Wait();
	}
	*/
	/*
	DebugConsole::OpenConsole();
	std::stringstream ss;
	ss << "cd C:\\Users\\shuta\\Documents\\Visual Studio 2015\\Projects\\RNNSimulator" << " & ";
	ss << "mkdir sample_d" << " & ";
	ss << "cd >> sample_d\\sample.txt";
	system(ss.str().c_str());
	DebugConsole::Wait();
	*/
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

	sample->set(4, "id", 64, "name", "va", "data", 0.5f, "ptr", &sample);

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

	RNNSimulator::FigureViewer* sample1 = new RNNSimulator::FigureViewer();
	std::cout << "id: " << sample1->id << ", nextId: " << sample1->NEXTID << ", nextFigId: " << sample1->NEXTFIGID << std::endl;
	RNNSimulator::FigureViewer* sample2 = new RNNSimulator::FigureViewer("offset_x 700");
	std::cout << "id: " << sample2->id << ", nextId: " << sample2->NEXTID << ", nextFigId: " << sample2->NEXTFIGID << std::endl;
	RNNSimulator::FigureViewer* sample3 = new RNNSimulator::FigureViewer("offset_y 480");
	std::cout << "id: " << sample3->id << ", nextId: " << sample3->NEXTID << ", nextFigId: " << sample3->NEXTFIGID << std::endl;
	RNNSimulator::FigureViewer* sample4 = new RNNSimulator::FigureViewer("offset_x 700 offset_y 480");
	std::cout << "id: " << sample4->id << ", nextId: " << sample4->NEXTID << ", nextFigId: " << sample4->NEXTFIGID << std::endl;

	sample1->set("size_x 1280 offset_x 100 linewidth 5");

	sample1->plot("sin(x)", "red", "SIN");
	sample1->fig->holdOn();
	sample1->plot("cos(x)", "blue");
	sample1->plot("tanh(x)", "green");
	sample1->fig->holdOff();

	int num = 1000; double dx = 4 * M_PI / num;
	std::vector<double> xvec(num);
	std::vector<double> yvec1(num);
	std::vector<double> yvec2(num);
	for (int i = 0;i < num;i++) {
		xvec.at(i) = dx*i - 2 * M_PI;
		yvec1.at(i) = sin(xvec.at(i));
		yvec2.at(i) = cos(xvec.at(i));
	}
//td::vector<std::string> colors = { "red", "blue" };
//td::vector<std::string> titles = { "SIN", "COS" };

	sample2->set(2, "x", "time [s]", "y", "value");
	sample2->plot_datavar(2, { "red", "blue" }, { "SIN", "COS" }, 
		xvec, yvec1, yvec2);
	sample3->fig->hwrite("plot sin(x)");
	sample4->fig->hwrite("plot sin(x)");

	DebugConsole::OpenConsole();

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

	return 0;
}

int DebugMain::RecorderTest() {
	DebugConsole::OpenConsole();
	std::cout << "Recorder Test: " << std::endl;
//	RNNSimulator::IdManager* obj = RNNSimulator::IdManager::getObject();
	RNNSimulator::Findable* fin1 = new RNNSimulator::Findable();
	RNNSimulator::DataRecorder* dr1 = new RNNSimulator::DataRecorder();
	RNNSimulator::Findable* fin2 = new RNNSimulator::Findable();
	RNNSimulator::DataRecorder* dr2 = new RNNSimulator::DataRecorder("sample");

	std::cout << dr1->recordId << ":(" << dr1->id << ") " << dr1->recordName << std::endl;
	std::cout << dr2->recordId << ":(" << dr2->id << ") " << dr2->recordName << std::endl;
//	std::cout << obj->setup.folder << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
	return 0;
}

int DebugMain::RNNTest() {
	DebugConsole::OpenConsole();

	std::cout << "RNNTest:" << std::endl;
	RNNSimulator::RNNNode* rnn = new RNNSimulator::RNNNode(1, "n", 8);
	RNNSimulator::Observer* obs = new RNNSimulator::Observer(1, "target", rnn);
	obs->viewTarget();
	RNNSimulator::Connector* con = new RNNSimulator::Connector(rnn, rnn, 1);

	/*
	std::cout << "RNN: " << std::endl;
	std::cout << "Pointer: " << rnn << std::endl;
	std::cout << "N: " << rnn->cellNum << std::endl;
	Eigen::MatrixXd tmp; tmp = Eigen::MatrixXd::Identity(rnn->cellNum, rnn->cellNum);
	tmp = rnn->network;
	std::cout << tmp << std::endl;
	*/

	while (1) {
		rnn->update();
		con->transmit();
		obs->viewTarget();
		Sleep(100);
		if (DebugConsole::WaitKey('q')) {
			std::cout << "quit" << std::endl;
			break;
		}
	}

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
	return 0;
}

int DebugMain::TemporalObserverTest() {
	DebugConsole::OpenConsole();

	std::cout << "RNNTest:" << std::endl;
	RNNSimulator::SimTime simtime(10);
	RNNSimulator::RNNNode* rnn = new RNNSimulator::RNNNode(1, "n", 32);
	RNNSimulator::TemporalObserver* obs = new RNNSimulator::TemporalObserver(1, "target", rnn);
	obs->viewTarget();
	RNNSimulator::Connector* con = new RNNSimulator::Connector(rnn, rnn, 1);

	while (simtime.ok()) {
		rnn->update();
		con->transmit();
		obs->viewTarget();
		Sleep(100);
		if (DebugConsole::WaitKey('q')) {
			std::cout << "quit" << std::endl;
			break;
		}
		simtime.step();
	}

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
	return 0;
}

int DebugMain::FORCETest() {
	RNNSimulator::SimTime* simtime = new RNNSimulator::SimTime(1,0.2);

	RNNSimulator::RNNNode* rnn = new RNNSimulator::RNNNode(1, "n", 32);
//	RNNSimulator::ConnectableNode* output = new RNNSimulator::ConnectableNode(1, "n", 2);
//	RNNSimulator::RLSModule* fm = new RNNSimulator::RLSModule(1, rnn, output);
//	RNNSimulator::Connector* feedback = new RNNSimulator::Connector(output, rnn, 1);
	RNNSimulator::FORCEModule* fm = new RNNSimulator::FORCEModule(rnn);
	fm->rls->param->set(1, "alpha", 0.01); fm->rls->init();
	RNNSimulator::TemporalObserver* obs = new RNNSimulator::TemporalObserver(1, "target", fm);

	DebugConsole::OpenConsole();

	std::cout << "n: " << fm->cellNum << std::endl;
	std::cout << "a: " << fm->rls->param->alpha << std::endl;
	std::cout << "wo:" << fm->rls->weight << std::endl;
	std::cout << "P: " << fm->rls->P << std::endl;
	std::cout << "wf:" << fm->feedback->weight << std::endl;

	DebugConsole::Wait();
	/**/
	while(simtime->ok()){
		rnn->update();
		fm->updateFORCE();
		std::cout << "e: " << fm->rls->error << std::endl;
//		std::cout << "wo:" << fm->rls->weight << std::endl;
//		std::cout << "P: " << fm->rls->P << std::endl;

		std::cout << simtime->ti << ": " << fm->readout << std::endl;
		obs->viewTarget();
		simtime->step();
	}
	/**/
	std::cout << "tt" << std::endl;
	obs->viewer->fig->save("testFile/debugFRC.emf");

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
	gp2->plotVec2Raw(xvec, yvec1, "with lines linewidth 3 linecolor 'orange' title \"sin(x)\"");

	std::vector<std::vector<double>> yvecarray{yvec1, yvec2};
	std::vector<std::string> optionarray{ "with lines lw 3 lc 'cyan' title 'sin(x)'", "with lines lw 3 lc 'magenta' title 'cos(x)'"};
	double* yptrarray[2] = { yptr1, yptr2 };
	std::string optptrarray[2] = { "with lines lw 3 lc 'cyan' title 'sin(x)'", "with lines lw 3 lc 'magenta' title 'cos(x)'" };

	gp3->hwrite(ss.str());
	gp3->plotVec2Multi(xvec, yvecarray, optionarray);

	gp4->hwrite(ss.str());
	gp4->plotVec2Multi(xptr, num, yptrarray, 2, optptrarray);

	gp1->save("testFile/debugGP.png", "png");

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

int DebugMain::EigenTest() {
	Eigen::MatrixXd vec;
	std::vector<double> svec;
	double* data, *sdata;
	//data.resize(2, 3);
	vec = Eigen::MatrixXd::Zero(2, 3);
	svec = { 1,4,2,5,3,6 };
	data = (double*)&vec(0);
	sdata = (double*)&svec.at(0);

	DebugConsole::OpenConsole();

	for (int i = 0;i < 6;i++) {
		std::cout << data[i] << ", ";
 	}
	std::cout << std::endl;

	vec << 1, 2, 3,
		4, 5, 6;

	for (int i = 0;i < 6;i++) {
		std::cout << data[i] << ", ";
	}
	std::cout << std::endl;

	for (int i = 0;i < 6;i++) {
		std::cout << sdata[i] << ", ";
	}
	std::cout << std::endl;

	std::cout << "Ptr: " << &sdata[0] << std::endl;
	for (int i = 0; i < 6; i++) {
		std::cout << i << ": " << &sdata[i] << " | " << &vec(i) << std::endl;
	}

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
}

int DebugMain::RandomTest() {
	DebugConsole::OpenConsole();

	std::random_device rd;
	std::mt19937 gen(rd());
	std::normal_distribution<> d(0, 1);

	std::vector<double> tmpvec(30000), hist(100);
	for (int i = 0; i < 30000;i++) {
		tmpvec.at(i) = d(gen);
	}
	std::sort(tmpvec.begin(), tmpvec.end());
	int j = 0;
	for (int i = 0;i < 30000;i++) {
		if (j < 100 && tmpvec.at(i) >= -3 + 0.06*j) {
			j += 1;
		}
		if (j == 100) hist.at(j - 1) += 1;
		else hist.at(j) += 1;
	}
	std::vector<double> xvec(100), tvec(30000);
	for (int i = 0;i < 100;i++) {
		xvec.at(i) = -2.97 + 0.06*i;
	}
	for (int i = 0;i < 30000;i++) {
		tvec.at(i) = i;
	}
	Gnuplot::GP* gp = new Gnuplot::GP();
	gp->plotVec2(&xvec.at(0), &hist.at(0), 100);

	DebugConsole::Wait();
	gp->plotVec2(&tvec.at(0), &tmpvec.at(0), 30000);

	DebugConsole::Wait();
	DebugConsole::CloseConsole();

}