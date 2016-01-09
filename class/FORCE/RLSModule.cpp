#include "RLSModule.h"

using namespace RNNSimulator;

RLSModule::RLSModule(int mode_, Connectable* in_, Connectable* out_) 
: Connector(in_, out_), RLSPlasticity(mode_) {
	bind(this);
}
RLSModule::RLSModule(int mode_, Connectable* in_, Connectable* out_, int option)
: Connector(in_, out_, option), RLSPlasticity(mode_) {
	bind(this);
}
RLSModule::RLSModule(int mode_, Connectable* in_, Connectable* out_, std::vector<double> w)
: Connector(in_, out_, w), RLSPlasticity(mode_) {
	bind(this);
}
RLSModule::~RLSModule() {};

void RLSModule::update() {
	std::cout << in->outflow_len() << ":" << weight.cols() << std::endl;
	std::cout << out->inflow_len() << ":" << weight.rows() << std::endl;
	
	transmit();
	updateWeight();
}