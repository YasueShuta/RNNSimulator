#pragma once
#include <random>
#include <stdarg.h>
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
		Eigen::MatrixXd input;
		Eigen::MatrixXd weight;
		Eigen::MatrixXd output;
		int rows;
		int cols;
		double dt;

		Connector(Connectable* in, Connectable* out);
		Connector(Connectable* in, Connectable* out, int option, ...);
		Connector(Connectable* in, Connectable* out, std::vector<double> w);
		virtual ~Connector();
		
		void resetWeight();

		static Eigen::MatrixXd randn(int rows_, int cols_, double mu=0, double sigma=1);

//		std::vector<double> transmit(double dt);
		virtual Eigen::VectorXd transmit(int option = 0);
		virtual Eigen::VectorXd transmit(double dt_, int option = 0);
	};
}