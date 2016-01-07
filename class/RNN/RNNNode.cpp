#include "RNNNode.h"

using namespace RNNSimulator;

RNNNode::RNNNode() : RNNNode(0) {}
RNNNode::RNNNode(std::string argv) {
	setDefault();
	param = new RNNParameter(argv);
	set(argv);
	reset();
}
RNNNode::RNNNode(int varargnum, ...) {
	setDefault();
	va_list argv;
	va_start(argv, varargnum);
	param = new RNNParameter();
	set_inner(varargnum, argv);
	reset();
}
RNNNode::~RNNNode() {};

void RNNNode::reset() {
	param->reset();
	if (cellNum != param->n) {
		std::cout << "cellNum not matching..." << std::endl;
		cellNum = param->n;
	}
	ConnectableNode::reset();
	tanh_read();
	network = param->M0;
	potential = param->x0;
	scale = param->scale;
	dt = SimTime::getObject()->dt;
}

void RNNNode::update() {
	if (dt < 0) {
		std::cout << "Time Scale dt is not decided...: set 0.1" << std::endl;
		dt = 0.1;
	}
	potential += (-1 * potential + input + network * readout) * dt;
	tanh_read();
	output = readout;
}

int RNNNode::set_inner(int varargnum, va_list argv) {
	ConnectableNode::set_inner(varargnum, argv);
	param->set_inner(varargnum, argv);
	return varargnum;
}