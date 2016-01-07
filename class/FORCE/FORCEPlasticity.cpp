#include "FORCEPlasticity.h"

using namespace RNNSimulator;

FORCEPlasticity::FORCEPlasticity(int target_mode_) : FORCEPlasticity(target_mode_, 0) {};
FORCEPlasticity::FORCEPlasticity(int target_mode_, int varargnum, ...) {
	va_list argv;
	va_start(argv, varargnum);
	param = new FORCEParameter(varargnum, argv);
	setMode(target_mode_);
}
FORCEPlasticity::~FORCEPlasticity() {};

void FORCEPlasticity::setMode(int mode_) {
	target_mode = mode_;
}