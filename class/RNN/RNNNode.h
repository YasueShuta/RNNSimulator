#pragma once
#include "RNNParameter.h"
#include "../Connector/ConnectableNode.h"

namespace RNNSimulator {
	class RNNNode : public ConnectableNode {
	public:
		RNNParameter* param;
		double scale;
		double dt=-1;

		Eigen::MatrixXd network;

		RNNNode();
		RNNNode(std::string argv);
		RNNNode(int varargnum, ...);
		~RNNNode();

		virtual int set_inner(int varargnum, va_list argv) override;
		virtual void reset();
		virtual void update() override;
	};
}