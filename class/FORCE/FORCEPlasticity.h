#pragma once
#include "FORCEParameter.h"

namespace RNNSimulator {
	class FORCEPlasticity {
	public:
		FORCEParameter* param;

		Eigen::VectorXd error;
		Eigen::MatrixXd P;
		Eigen::MatrixXd dw;

		int target_mode;
		Connector* target;
		
		FORCEPlasticity();
		FORCEPlasticity(int varargnum, ...);
		~FORCEPlasticity();

		void bind(Connector* target_);


		void updateWeight(int ti);
		void updateError(int ti);
}
