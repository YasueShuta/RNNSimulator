#include "Node.h"

using namespace RNNSimulator;
Node::Node() : Node("") {}
Node::Node(std::string argv) {
	setDefault();
	set(argv);
}
Node::Node(int setvarnum, ...)
{
	setDefault();
	va_list argv;
	va_start(argv, setvarnum);
	set(setvarnum, argv);
	reset();
}

Node::~Node() {};

void Node::setDefault() {
	cellNum = 1;
	mode = 1;
}
void Node::reset() {
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
std::vector<double> Node::to_vec(Eigen::VectorXd src_) {
	std::vector<double> ret(cellNum);
	Eigen::Map<Eigen::VectorXd>(&ret[0], cellNum) = src_;
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

int Node::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	return argvnum;
}
int Node::set_inner(int argvnum, va_list argv) {
	return argvnum;
}