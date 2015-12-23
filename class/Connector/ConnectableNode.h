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
		
		int outflow_len();
		int inflow_len();
		Eigen::VectorXd outflow();
		void inflow(Eigen::VectorXd flow);
	};

}