#include "RLSPlasticity.h"
#include "../Connector/Connector.h"

using namespace RNNSimulator;

RLSPlasticity::RLSPlasticity(int target_mode_) : RLSPlasticity(target_mode_, 0) {};
RLSPlasticity::RLSPlasticity(int target_mode_, int varargnum, ...) {
	va_list argv;
	va_start(argv, varargnum);
	param = new RLSParameter(varargnum, argv);
	setMode(target_mode_);
}
RLSPlasticity::~RLSPlasticity() {};

void RLSPlasticity::setMode(int mode_) {
	target_mode = mode_;
}

void RLSPlasticity::bind(Connector* target_) {
	target = target_;
	init(target->rows, target->cols);
}

void RLSPlasticity::init(int row_, int col_) {
	if (isValid && row_ < 0) {
		row_ = target->rows;
		col_ = target->cols;
	}
	_r = Eigen::MatrixXd::Zero(col_, 1);
	_rPr = Eigen::MatrixXd::Zero(1,1);
	_k = Eigen::MatrixXd::Zero(col_, 1);
	_c = Eigen::MatrixXd::Zero(1, 1);

	if (param->r_alpha != 0) param->alpha = col_ * param->r_alpha;

	error = Eigen::MatrixXd::Zero(row_, 1);
	P = 1.0 / param->alpha * Eigen::MatrixXd::Identity(col_, col_);
	dw = Eigen::MatrixXd::Zero(row_, col_);

	target_value = Eigen::MatrixXd::Zero(row_, 1);
	isValid = true;
}

void RLSPlasticity::updateWeight(int ti) {
	if (!isValid) return;	
	if (ti < 0) ti = ti_count;
	ti_count += 1;
	updateError();
	if (ti % param->learn_every) return;
	_r = target->in->outflow();
	_k = P * _r;
	_rPr = _r.transpose() * _k;
	_c.array() = 1.0 / (1.0 + _rPr.array());
	P = P - _k * (_c * _k.transpose());
	dw = -1 * error * _c * _k.transpose();
	target->weight += dw;
}
void RLSPlasticity::updateError() {
	for (int i = 0;i < target_value.rows() ; i++) {
		target_value(i) = tf.next(target->dt, target_mode);
	}
	error = target->flow - target_value;
}