#pragma once

#include <vector>
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class Node
	{
	public:
		int mode;
		Eigen::VectorXd potential;
		Eigen::VectorXd readout;

		int cellNum;

		Node();
		Node(int num);
		Node(int num, int mode);
		virtual ~Node();

		std::vector<double> x2vec();
		std::vector<double> r2vec();

		virtual void update();
		void array_atanh();
	};
}

