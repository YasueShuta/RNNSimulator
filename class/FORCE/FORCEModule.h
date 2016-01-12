#pragma once

#include "../Connector/ConnectableNode.h"
#include "RLSModule.h"

namespace RNNSimulator {
	class FORCEModule {
	public:
		RLSModule* wo;
		ConnectableNode* node;
		Connector* wf;

		void update();

		FORCEModule(ConnectableNode* target_);
		virtual ~FORCEModule();
	};
}