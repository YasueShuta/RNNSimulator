#include "FORCEParameter.h"

using namespace RNNSimulator;

FORCEParameter::FORCEParameter() : FORCEParameter(0) {};
FORCEParameter::FORCEParameter(std::string argv) {
	setDefault();
	set(argv);
	reset();
}
FORCEParameter::FORCEParameter(int varargnum, ...) {
	va_list argv;
	va_start(argv, varargnum);
	FORCEParameter(varargnum, argv);
}
FORCEParameter::FORCEParameter(int varargnum, va_list argv) {
	setDefault();
	set_inner(varargnum, argv);
	reset();
}
FORCEParameter::~FORCEParameter() {};

void FORCEParameter::setDefault() {
	alpha = 0;
	r_alpha = 0.001;
	learn_every = 2;
}

void FORCEParameter::reset() {
	if (alpha == 0) alpha = 1.0;
}

int FORCEParameter::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	std::string str;
	for (int i = 0;i < argvnum;i++) {
		str = argvstr.at(i);
		if (str == "r_alpha" || str == "r") {
			r_alpha = std::stod(argvdata.at(i));
		}
		else if (str == "alpha" || str == "a") {
			alpha = std::stod(argvdata.at(i));
		}
		else if (str == "learn_every" || str == "le") {
			learn_every = std::stod(argvdata.at(i));
		}
	}
	return argvnum;
}
int FORCEParameter::set_inner(int varargnum, va_list argv) {
	std::string str;
	for (int i = 0;i < varargnum;i++) {
		str = va_arg(argv, char*);
		if (str == "r_alpha" || str == "r") {
			r_alpha = va_arg(argv, double);
		}
		else if (str == "alpha" || str == "a") {
			alpha = va_arg(argv, double);
		}
		else if (str == "learn_every" || str == "le") {
			learn_every = va_arg(argv, int);
		}
	}
	return varargnum;
}