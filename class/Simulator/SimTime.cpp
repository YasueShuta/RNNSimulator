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
