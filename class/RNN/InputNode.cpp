#include "InputNode.h"

using namespace RNNSimulator;

InputNode::InputNode() : InputNode(0, 0) {};
InputNode::InputNode(int mode_, int varargnum, ...) {
	va_list arg;
	va_start(arg, varargnum);

	input_mode = mode_;
	if (varargnum > 0) {
		gain = va_arg(arg, double);
	}
}
InputNode::~InputNode() {};

void InputNode::update() {
	switch (input_mode) {
	case 0:
		readout *= 0;
		output = readout;
		break;
	case 1:
		readout = gain * Eigen::MatrixXd::Ones(readout.rows(), readout.cols());
		output = readout;
		break;
	default:
		break;
	}
}