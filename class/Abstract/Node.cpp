#include "Node.h"

using namespace RNNSimulator;
Node::Node() : Node(1) {}
Node::Node(int num) : Node(num, 1) {}
Node::Node(int num, int mode_)
{
	cellNum = num;
	mode = mode_;
	switch (mode) {
	case 0:
		potential = Eigen::VectorXd::Zero(cellNum);
		break;
	case 1:
		potential = Eigen::VectorXd::Random(cellNum);
		break;
	default:
		potential = Eigen::VectorXd::Random(cellNum);
	}
	readout = potential;
}

Node::~Node() {};
std::vector<double> Node::x2vec() {
	std::vector<double> ret(cellNum);
	Eigen::Map<Eigen::VectorXd>(&ret[0], cellNum) = potential;
	return ret;
}
std::vector<double> Node::r2vec() {
	std::vector<double> ret(cellNum);
	Eigen::Map<Eigen::VectorXd>(&ret[0], cellNum) = readout;
	return ret;
}

void Node::update() {
	readout = potential;
}

void Node::array_atanh(){
	Eigen::ArrayXd x = potential.array();
	Eigen::ArrayXd r(x.size());
	for (int i = 0; i < r.size(); i++) {
		r[i] = atanh(x[i]);
	}
	readout = r.matrix();
}

