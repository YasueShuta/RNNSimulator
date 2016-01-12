#pragma once
#include "../Connector/ConnectableNode.h"
#include <stdarg.h>

namespace RNNSimulator {
	class InputNode : public ConnectableNode {
	public:
		int input_mode;
		double gain=1.0;

		InputNode();
		InputNode(int mode_, int varargnum, ...);
		~InputNode();

		virtual void update() override;
	};
}