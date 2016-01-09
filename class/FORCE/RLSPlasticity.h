#pragma once
#include "RLSParameter.h"
#include "TargetFunctionGenerator.h"

namespace RNNSimulator {
	class RLSPlasticity {
	private:
		Eigen::MatrixXd _r;
		Eigen::MatrixXd _rPr;
		Eigen::MatrixXd _k;
		Eigen::MatrixXd _c;
		bool isValid = false;
		TargetFunctionGenerator tf;
		int ti_count=0;
	public:
		RLSParameter* param;

		Eigen::MatrixXd error;
		Eigen::MatrixXd P;
		Eigen::MatrixXd dw;

		int target_mode;
		Connector* target;
		Eigen::MatrixXd target_value;

		RLSPlasticity(int target_mode_ = 0);
		RLSPlasticity(int target_mode_, int varargnum, ...);
		~RLSPlasticity();

		void setMode(int mode_);
		void bind(Connector* target_);
		void init(int row_=-1, int col_=-1);

		void updateWeight(int ti=-1);
		void updateError();
	};
}
