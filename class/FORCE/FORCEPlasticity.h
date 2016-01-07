#pragma once
#include "FORCEParameter.h"
#include "TargetFunctionGenerator.h"

namespace RNNSimulator {
	class FORCEPlasticity {
	public:
		FORCEParameter* param;

		Eigen::VectorXd error;
		Eigen::MatrixXd P;
		Eigen::MatrixXd dw;

		int target_mode;
		Connector* target;

		FORCEPlasticity(int target_mode_ = 0);
		FORCEPlasticity(int target_mode_, int varargnum, ...);
		~FORCEPlasticity();

		void setMode(int mode_);
		void bind(Connector* target_);


		void updateWeight(int ti);
		void updateError(int ti);
	};
}
