#include "Connectable.h"

int RNNSimulator::Connectable::outflow_len() {
	return 0;
}

int RNNSimulator::Connectable::inflow_len() {
	return 0;
}

/*
std::vector<double> RNNSimulator::Connectable::outflow() {
	std::vector<double> ret(outflow_len(), 0);

	return ret;
}
*/
Eigen::VectorXd RNNSimulator::Connectable::outflow() {
	Eigen::VectorXd ret = Eigen::VectorXd::Zero(outflow_len());
	return ret;
}

void RNNSimulator::Connectable::inflow(std::vector<double> flow) {
}

void RNNSimulator::Connectable::inflow(Eigen::VectorXd flow) {
}