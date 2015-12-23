#include "Connector.h"
#include <iostream>

using namespace RNNSimulator;

Connector::Connector(Connectable* in_, Connectable* out_)
	: Connector(in_, out_, 0) {}
Connector::Connector(Connectable* in_, Connectable* out_, int option)
{
	in = in_;
	out = out_;
	rows = out->inflow_len();
	cols = in->outflow_len();
	switch (option) {
	case 0:
		weight = Eigen::MatrixXd::Zero(rows, cols);
		break;
	case 1:
		weight = Eigen::MatrixXd::Random(rows, cols);
		break;
	default:
		weight = Eigen::MatrixXd::Random(rows, cols);
	}
	w0 = std::vector<double>(rows * cols);
	Eigen::Map<Eigen::MatrixXd>(&w0[0], rows, cols) = weight;
}
Connector::Connector(Connectable* in_, Connectable* out_, std::vector<double> w)
	: Connector(in_, out_)
{
	w0 = w;
	resetWeight();
}
Connector::~Connector()
{
}

void Connector::resetWeight()
{
	weight = Eigen::Map<Eigen::MatrixXd>(&w0[0], rows, cols);
}

Eigen::VectorXd Connector::transmit(double dt) {
	Eigen::VectorXd flow = weight * in->outflow() * dt;
	return flow;
}