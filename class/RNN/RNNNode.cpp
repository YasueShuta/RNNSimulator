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
	param = new RNNParameter(varargnum, argv);
	set_inner(varargnum, argv);
	reset();
}
RNNNode::~RNNNode() {};

void RNNNode::reset() {
	ConnectableNode::reset();
	if (cellNum != param->n) {
		std::cout << "cellNum not matching..." << std::endl;
		cellNum = param->n;
	}
	network = param->M0;
	potential = param->x0;
	scale = param->scale;
}

void RNNNode::update() {
	if (dt < 0) {
		std::cout << "Time Scale dt is not decided...: set 0.1" << std::endl;
		dt = 0.1;
	}
	potential += (-1 * potential + input) * dt;
	atanh_read();
	output = readout;
}