#include "TemporalObserver.h"

using namespace RNNSimulator;

TemporalObserver::TemporalObserver(int varargnum, ...) {
	setDefault();
//	viewer->set(2, "x", "Time [s]", "y", "Value");
	std::cout << viewer << std::endl;
	time = SimTime::getObject();
	va_list argv;
	va_start(argv, varargnum);
	set_inner(varargnum, argv);
	reset();
}

void TemporalObserver::setTargetData() {
	if (target == NULL) return;
	datalen = time->len;
	datavec = std::vector<double>(datalen, 0);
}
void TemporalObserver::setXvec() {
	xvec = time->data;
}

void TemporalObserver::viewTarget() {
	datavec.at(time->ti) = target->readout.norm();//sqrt(target->readout.norm());
	viewer->fig->plotVec2(xvec, datavec);
}