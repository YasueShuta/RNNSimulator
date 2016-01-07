#include "Observer.h"

using namespace RNNSimulator;

#ifndef _OBSERVER_CPP
#define _OBSERVER_CPP
int Observer::NEXTOBJID = 0;

#endif

Observer::Observer(int argvnum, ...)
{
	setDefault();
	va_list argv;
	va_start(argv, argvnum);
	set_inner(argvnum, argv);
	reset();
}
Observer::~Observer()
{
}

void Observer::setDefault() {
	isValid = false;
	flag = "initialize";
	print_every = 100;
	plot_every = 1000;

	viewer = NULL;
	dataptr = NULL;
}
void Observer::reset() {
	setId();
	if(dataptr == NULL)
		setTargetData();
	if (viewer == NULL)
		setViewer();
}
void Observer::setId() {
	id = Observer::NEXTOBJID;
	Observer::NEXTOBJID += 1;
}
void Observer::setTargetData() {
	if (target == NULL) return;
	dataptr = &target->readout(0);
	datalen = target->cellNum;
	xvec.resize(datalen);
	for (int i = 0;i < datalen;i++) {
		xvec.at(i) = i;
	}
}
void Observer::setViewer() {
	if (target == NULL || datalen == 0) return;
	viewer = new FigureViewer();
}


void Observer::viewTarget() {
	viewer->fig->plotVec2(&xvec.at(0), (double*)dataptr, datalen, "title 'data'");
}

int Observer::set_inner(int argvnum, va_list argv) {
	for (int i = 0;i < argvnum; i++) {
		std::string tmp = va_arg(argv, char*);
		if (tmp == "target" || tmp == "t") {
			target = va_arg(argv, Node*);
		}
		else if (tmp == "print_every" || tmp == "print") {
			print_every = va_arg(argv, int);
		}
		else if (tmp == "plot_every" || tmp == "plot") {
			plot_every = va_arg(argv, int);
		}
		else if (tmp == "recorder" || tmp == "r") {
			std::cout << "Not Yet" << std::endl;
		}
		else if (tmp == "viewer" || tmp == "v") {
			viewer = va_arg(argv, FigureViewer*);
		}
		else if (tmp == "dstfile" || tmp == "file" || tmp == "f") {
			dstfile = va_arg(argv, char*);
		}
		else if (tmp == "datavec" || tmp == "data") {
			dataptr = va_arg(argv, void*);
		}
	}
	return 0;
	
}