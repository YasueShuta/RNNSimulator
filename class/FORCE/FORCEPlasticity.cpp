#include "FORCEPlasticity.h"
#include "../Connector/Connector.h"

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

void FORCEPlasticity::bind(Connector* target_) {
	target = target_;
	init(target->rows, target->cols);
}

void FORCEPlasticity::init(int row_, int col_) {
	_r = Eigen::MatrixXd::Zero(col_, 1);
	_rPr = Eigen::MatrixXd::Zero(1,1);
	_k = Eigen::MatrixXd::Zero(col_, 1);
	_c = Eigen::MatrixXd::Zero(1, 1);

	if (param->r_alpha != 0) param->alpha = col_ * param->r_alpha;

	error = Eigen::MatrixXd::Zero(1, row_);
	P = 1.0 / param->alpha * Eigen::MatrixXd::Identity(col_, col_);
	dw = Eigen::MatrixXd::Zero(row_, col_);
}

void FORCEPlasticity::updateWeight(int ti) {
	if (!isValid) return;
	if (ti < 0) ti = ti_count;
	updateError();
	if (ti%param->learn_every) return;
	_r = target->in->outflow();
	_k = P * _r;
	_rPr = _r.transpose() * _k;
	_c.array() = 1.0 / (1.0 + _rPr.array());
	P = P - _k * (_k.transpose() * _c);
	dw = -1 * _c * error.transpose() * _k.transpose();
	target->weight += dw;
	ti_count += 1;
}
void FORCEPlasticity::updateError() {
	error.array() = target->flow.array() - tf.next(target->dt, target_mode);
}