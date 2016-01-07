#include "TemporalObserver.h"

using namespace RNNSimulator;

TemporalObserver::TemporalObserver(int varargnum, ...) {
	setDefault();
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
	datavec.at(time->ti) = sqrt(target->readout.norm());
	viewer->fig->plotVec2(xvec, datavec);
}