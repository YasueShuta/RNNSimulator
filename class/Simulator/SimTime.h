#pragma once
#include "../Abstract/Findable.h"
#include <vector>

namespace RNNSimulator {
	class SimTime : public Findable {
	public:
		std::vector<double> data;
		int ti;
		double now;
		int len;
		double nsecs;

		double dt;

		SimTime(double nsecs = 144.0, double dt = 0.1);
		~SimTime();
	};
}