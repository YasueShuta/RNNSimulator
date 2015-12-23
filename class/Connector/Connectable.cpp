#include "Connectable.h"

int RNNSimulator::Connectable::outflow_len() {
	return 0;
}

int RNNSimulator::Connectable::inflow_len() {
	return 0;
}

std::vector<double> RNNSimulator::Connectable::outflow() {
	std::vector<double> ret(outflow_len(), 0);

	return ret;
}

void RNNSimulator::Connectable::inflow(std::vector<double> flow) {
}
