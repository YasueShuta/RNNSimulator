#include "ConnectableNode.h"

using namespace RNNSimulator;

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
	return readout;
}
void ConnectableNode::inflow(Eigen::VectorXd flow)
{
	potential += flow;
	update();
}