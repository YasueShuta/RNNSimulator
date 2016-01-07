#include "FORCEModule.h"

using namespace RNNSimulator;

FORCEModule::FORCEModule(Connectable* in_, Connectable* out_) 
: Connector(in_, out_) {
	bind(this);
}
FORCEModule::FORCEModule(Connectable* in_, Connectable* out_, int option)
: Connector(in_, out_, option) {
	bind(this);
}
FORCEModule::FORCEModule(Connectable* in_, Connectable* out_, std::vector<double> w)
: Connector(in_, out_, w) {
	bind(this);
}
FORCEModule::~FORCEModule() {};

void FORCEModule::update() {
	transmit();
	updateWeight();
}