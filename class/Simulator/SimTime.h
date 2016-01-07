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

		SimTime(double nsecs_ = 144.0, double dt_ = 0.1);
		~SimTime();

		static SimTime* getObject();
		static SimTime* getObject(double nsecs_, double dt_ = 0.1);
	};
}