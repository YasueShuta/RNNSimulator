#pragma once
#include "RNNParameter.h"
#include "../Connector/ConnectableNode.h"

namespace RNNSimulator {
	class RNNNode : public ConnectableNode {
	public:
		RNNParameter* param;
		double scale;

		Eigen::MatrixXd network;

		RNNNode();
		RNNNode(int varargnum, ...);
		~RNNNode();

		virtual void reset();
		virtual void update() override;
	};
}