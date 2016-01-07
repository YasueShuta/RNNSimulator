#include "SimTime.h"

using namespace RNNSimulator;

SimTime::SimTime(double nsecs_, double dt_) {
	dt = dt_;
	nsecs = nsecs_;
	len = round(nsecs / dt);
	data.resize(len);
	for (int i = 0;i < len;i++) {
		data.at(i) = i*dt;
	}
	ti = 0;
	now = 0;
}
SimTime::~SimTime(){}

void SimTime::reset() {
	ti = 0;
	now = 0;
}
void SimTime::step() {
	ti += 1;
	now += dt;
}

bool SimTime::ok() {
	if (ti >= 0 && ti < len) return true;
	return false;
}

SimTime* SimTime::getObject() {
	SimTime* ret;
	ret = findObject<SimTime>();
	if (ret == NULL) {
		ret = new SimTime();
	}
	return ret;
}
SimTime* SimTime::getObject(double nsecs_, double dt_) {
	SimTime* ret;
	ret = findObject<SimTime>();
	if (ret == NULL || ret->nsecs != nsecs_ || ret->dt != dt_) {
		delete ret;
		ret = new SimTime(nsecs_, dt_);
	}
	return ret;
}