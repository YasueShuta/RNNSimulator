#pragma once
#include <vector>

namespace RNNSimulator {
	class TargetFunctionGenerator {
	public:
		int mode;
		double next(double dt = 0, int mode_ = -1);

		TargetFunctionGenerator() {};
		~TargetFunctionGenerator() {};

	private:
		double gain = 1.0;
		double freq = 0.001;
		double phase = 0.0;
		double prev;
	};

}