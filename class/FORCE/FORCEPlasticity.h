#pragma once
#include "FORCEParameter.h"
#include "TargetFunctionGenerator.h"

namespace RNNSimulator {
	class FORCEPlasticity {
	private:
		Eigen::MatrixXd _r;
		Eigen::MatrixXd _rPr;
		Eigen::MatrixXd _k;
		Eigen::MatrixXd _c;
		bool isValid = false;
		TargetFunctionGenerator tf;
		int ti_count=0;
	public:
		FORCEParameter* param;

		Eigen::MatrixXd error;
		Eigen::MatrixXd P;
		Eigen::MatrixXd dw;

		int target_mode;
		Connector* target;

		FORCEPlasticity(int target_mode_ = 0);
		FORCEPlasticity(int target_mode_, int varargnum, ...);
		~FORCEPlasticity();

		void setMode(int mode_);
		void bind(Connector* target_);
		void init(int row_, int col_);

		void updateWeight(int ti=-1);
		void updateError();
	};
}
