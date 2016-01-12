#include "FORCEModule.h"

using namespace RNNSimulator;

FORCEModule::FORCEModule(ConnectableNode* target_) {
	node = new ConnectableNode();
	wo = new RLSModule(1, target_, node);
	wf = new Connector(node, target_, 2, 0.0, 1.0);
}
FORCEModule::~FORCEModule(){}

void FORCEModule::update() {
	wo->update();
	node->update();
	wf->transmit();
}