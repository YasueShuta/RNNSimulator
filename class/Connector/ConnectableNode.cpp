#include "ConnectableNode.h"

using namespace RNNSimulator;

ConnectableNode::ConnectableNode() : ConnectableNode("") {}
ConnectableNode::ConnectableNode(std::string argv) : Node(argv) {}
ConnectableNode::ConnectableNode(int varargnum, ...){
	va_list argv;
	va_start(argv, varargnum);
	set_inner(varargnum, argv);
	reset();
}

void ConnectableNode::reset() {
	Node::reset();
	output = readout;
	input = Eigen::VectorXd::Zero(cellNum);
}

int ConnectableNode::outflow_len()
{
	return cellNum;
}
int ConnectableNode::inflow_len()
{
	return cellNum;
}
Eigen::VectorXd ConnectableNode::outflow()
{
	return output;
}
void ConnectableNode::inflow(Eigen::VectorXd flow, int option)
{
	switch (option) {
	case 1:
		input += flow;
		break;
	default:
		input = flow;
	}
	update();
}
void ConnectableNode::update()
{
	potential = input;
	Node::update();
	output = readout;
}