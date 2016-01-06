#include "RNNParameter.h"

using namespace RNNSimulator;

RNNParameter::RNNParameter() : RNNParameter(0) {}
RNNParameter::RNNParameter(std::string argv) {
	setDefault();
	set(argv);
	reset();
}
RNNParameter::RNNParameter(int varargnum, ...) {
	setDefault();
	va_list argv;
	va_start(argv, varargnum);
	set_inner(varargnum, argv);
	reset();
}
RNNParameter::RNNParameter(int varargnum, va_list argv) {
	setDefault();
	set_inner(varargnum, argv);
	reset();
}
RNNParameter::~RNNParameter() {}

void RNNParameter::reset() {
	scale = 1.0 / sqrt(n*p);
	setNetwork();
	setPotential();
}
void RNNParameter::setDefault() {
	n = 64;
	p = 0.1;
	g = 1.5;
	th = 0.5;
}
void RNNParameter::setNetwork() {
	if (isLoadedNetwork) {
		// load network from loadnetname file
	}
	else {
		// Sparse
		M0 = nrand(n, p, 0, g*scale);
	}
}
void RNNParameter::setPotential() {
	if (isLoadedPotential) {
		// load potential from loadxname file
	}
	else {
		x0 = 2.0 * Eigen::VectorXd::Random(n);
		x0.array() - 1.0;
	}
}
void RNNParameter::setPlastic() {
	isPlastic = true;
}
void RNNParameter::resetPlastic() {
	isPlastic = false;
}

RNNParameter* RNNParameter::init(int n_,
	double p_,
	double g_,
	double th_,
	std::string loadnetname_,
	std::string loadxname_) {
	std::string str = "";
	if (n_ > 0)	str += "-n " + std::to_string(n_);
	if (p_ > 0) str += " -p " + std::to_string(p_);
	if (g_ > 0) str += " -g " + std::to_string(g_);
	if (th_ > 0) str += " -th " + std::to_string(th_);
	if (loadnetname_.length() > 0)
		str += " -net " + loadnetname_;
	if (loadxname_.length() > 0)
		str += " -x " + loadxname_;
	return new RNNParameter(str);
}

Eigen::SparseMatrix<double> RNNParameter::nrand(int n_, double p_, double mean, double dev) {
	std::random_device rd;
	std::mt19937 gen(rd());
	std::normal_distribution<> nd(mean, dev);
	std::uniform_real_distribution<> ud(0,1);

	std::vector<Eigen::Triplet<double>> vec;

	double d;
	for (int i = 0;i < n_;i++) {
		for (int j = 0;j < n_;j++) {
			d = ud(gen);
			if (p_ < d) break;
			d = nd(gen);
			vec.push_back(Eigen::Triplet<double>(d, i, j));
		}
	}

	Eigen::SparseMatrix<double> s(n_, n_);
	s.setFromTriplets(vec.begin(), vec.end());
	return s;
}

int RNNParameter::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	std::string str;
	for (int i = 0; i < argvnum; i++) {
		str = argvstr.at(i);
		if (str == "cellNum" || str == "num" || str == "n") {
			n = std::stoi(argvdata.at(i));
		}
		else if (str == "p") {
			p = std::stod(argvdata.at(i));
		}
		else if (str == "g") {
			g = std::stod(argvdata.at(i));
		}
		else if (str == "th") {
			th = std::stod(argvdata.at(i));
		}
		else if (str == "loadnetname" || str == "loadnet" || str == "net") {
			loadnetname = argvdata.at(i);
			isLoadedNetwork = true;
		}
		else if (str == "loadxname" || str == "loadx" || str == "x") {
			loadxname = argvdata.at(i);
			isLoadedPotential = true;
		}
	}
	return argvnum;
}
int RNNParameter::set_inner(int varargnum, va_list argv) {
	std::string str;
	for (int i = 0; i < varargnum; i++) {
		str = va_arg(argv, char*);
		if (str == "cellNum" || str == "num" || str == "n") {
			n = va_arg(argv, int);
		} else if(str == "p") {
			p = va_arg(argv, double);
		}
		else if (str == "g") {
			g = va_arg(argv, double);
		}
		else if (str == "th") {
			th = va_arg(argv, double);
		}
		else if (str == "loadnetname" || str == "loadnet" || str == "net") {
			loadnetname = va_arg(argv, char*);
			isLoadedNetwork = true;
		}
		else if (str == "loadxname" || str == "loadx" || str == "x") {
			loadxname = va_arg(argv, char*);	
			isLoadedPotential = true;
		}
	}
	return varargnum;
}