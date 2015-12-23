#pragma once
#include "..\..\..\eigen\Eigen\Core"
#include "Connectable.h"

namespace RNNSimulator {
	class Connector
	{
	public:
		Connectable* in;
		Connectable* out;
		std::vector<double> w0;
		Eigen::MatrixXd weight;
		int rows;
		int cols;

		Connector(Connectable* in, Connectable* out);
		Connector(Connectable* in, Connectable* out, int option);
		Connector(Connectable* in, Connectable* out, std::vector<double> w);
		~Connector();
		
		void resetWeight();

//		std::vector<double> transmit(double dt);
		Eigen::VectorXd transmit(double dt);
	};
}