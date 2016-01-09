#include "FORCEModule.h"

using namespace RNNSimulator;

FORCEModule::FORCEModule(ConnectableNode* target_) {
	rls = new RLSModule(1, target_, this);
	feedback = new Connector(this, target_, 1);
}
FORCEModule::~FORCEModule(){}

void FORCEModule::updateFORCE() {
	rls->update();
//	ConnectableNode::update();
	feedback->transmit();
}