#pragma once
#include <vector>
#define _USE_MATH_DEFINES
#include <math.h>

namespace RNNSimulator {
	class TargetFunctionGenerator {
	public:
		int mode;
		double next(double dt = 0, int mode_ = -1) {
			if (mode_ < 0) mode_ = mode;
			double ret;
			switch (mode_) {
			case 0:
				ret = 0;
				break;
			case 1:
				ret = gain;
				break;
			case 2:
				ret = gain * sin(2 * M_PI*freq*t_);
				t_ += dt;
				break;
			case 3:
				ret = (2-freq*freq*dt*dt)*prev1 - prev2;
				prev2 = prev1;
				prev1 = ret;
				break;
			default:
				ret = 0;
			}
			return ret;
		}

		TargetFunctionGenerator() {};
		~TargetFunctionGenerator() {};

		double gain = 1.0;
		double freq = 0.001;
		double phase = 0.0;
		double prev1 = 0;
		double prev2 = 0;
	private:
		double t_ = 0;
	};

}