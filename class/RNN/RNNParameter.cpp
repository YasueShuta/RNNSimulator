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
	setNetwork();
	setPotential();
}


