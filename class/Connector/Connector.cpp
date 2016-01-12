#include "Connector.h"
#include <iostream>

using namespace RNNSimulator;

Connector::Connector(Connectable* in_, Connectable* out_)
	: Connector(in_, out_, 0) {}
Connector::Connector(Connectable* in_, Connectable* out_, int option, ...)
{
	va_list arg;
	va_start(arg, option);
	double vd1, vd2;

	in = in_;
	out = out_;
	rows = out->inflow_len();
	cols = in->outflow_len();
	switch (option) {
	case 0:
		weight = Eigen::MatrixXd::Zero(rows, cols);
		break;
	case 1:
		vd1 = va_arg(arg, double);
		weight = vd1*Eigen::MatrixXd::Random(rows, cols);
		break;
	case 2:
		vd1 = va_arg(arg, double);
		vd2 = va_arg(arg, double);
		weight = randn(rows, cols, vd1, vd2);
		break;
	default:
		weight = Eigen::MatrixXd::Random(rows, cols);
	}
	w0 = std::vector<double>(rows * cols);
	Eigen::Map<Eigen::MatrixXd>(&w0[0], rows, cols) = weight;
	dt = SimTime::getObject()->dt;
}
Connector::Connector(Connectable* in_, Connectable* out_, std::vector<double> w)
	: Connector(in_, out_)
{
	w0 = w;
	resetWeight();
	dt = SimTime::getObject()->dt;
}
Connector::~Connector()
{
}

void Connector::resetWeight()
{
	weight = Eigen::Map<Eigen::MatrixXd>(&w0[0], rows, cols);
}

Eigen::MatrixXd Connector::randn(int rows_, int cols_, double mu_, double sigma_)
{
	Eigen::MatrixXd ret;
	ret.resize(rows_, cols_);
	std::random_device rd;
	std::mt19937 gen(rd());
	std::normal_distribution<> nd(mu_, sigma_);
	for (int i = 0;i < ret.size();i++) {
		ret(i) = nd(gen);
	}
	std::cout << mu_ << ", " << sigma_ << std::endl;
	return ret;
}

Eigen::VectorXd Connector::transmit() {
	input = in->outflow();
	output = weight * input * dt;
	out->inflow(output);
	return output;
}
Eigen::VectorXd Connector::transmit(double dt_) {
	if (dt_ <= 0) dt_ = dt;
	input = in->outflow();
	output = weight * input * dt_;
	out->inflow(output);
	return output;
}

