#pragma once
#include "..\..\..\eigen\Eigen\Core"
#include "Connectable.h"
#include "../Simulator/SimTime.h"

namespace RNNSimulator {
	class Connector
	{
	public:
		Connectable* in;
		Connectable* out;
		std::vector<double> w0;
		Eigen::MatrixXd weight;
		Eigen::MatrixXd flow;
		int rows;
		int cols;
		double dt;

		Connector(Connectable* in, Connectable* out);
		Connector(Connectable* in, Connectable* out, int option);
		Connector(Connectable* in, Connectable* out, std::vector<double> w);
		virtual ~Connector();
		
		void resetWeight();

//		std::vector<double> transmit(double dt);
		virtual Eigen::VectorXd transmit();
		virtual Eigen::VectorXd transmit(double dt_);
	};
}