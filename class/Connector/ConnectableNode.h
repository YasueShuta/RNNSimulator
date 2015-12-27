#pragma once

#include "../Abstract/Node.h"
#include "Connectable.h"

namespace RNNSimulator {
	class ConnectableNode : public Node, public Connectable
	{
	public:
		ConnectableNode() : Node() {};
		ConnectableNode(int n) : Node(n) {};
		ConnectableNode(int n, int mode) : Node(n, mode) {};
		
		virtual int outflow_len() override;
		virtual int inflow_len() override;
		virtual Eigen::VectorXd outflow() override;
		virtual void inflow(Eigen::VectorXd flow) override;
	};

}