#pragma once

#include "../Abstract/Node.h"
#include "Connectable.h"

namespace RNNSimulator {
	class ConnectableNode : public Node, public Connectable
	{
	public:
		Eigen::VectorXd input;
		Eigen::VectorXd output;


		ConnectableNode();
		ConnectableNode(std::string argv);
		ConnectableNode(int varargnum, ...);
		
		virtual void reset() override;
		virtual int outflow_len() override;
		virtual int inflow_len() override;
		virtual Eigen::VectorXd outflow() override;
		virtual void inflow(Eigen::VectorXd flow) override;
		virtual void update() override;
	};

}