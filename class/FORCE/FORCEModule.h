#pragma once

#include "../Connector/ConnectableNode.h"
#include "RLSModule.h"

namespace RNNSimulator {
	class FORCEModule : public ConnectableNode {
	public:
		RLSModule* rls;
		Connector* feedback;

		void updateFORCE();

		FORCEModule(ConnectableNode* target_);
		virtual ~FORCEModule();
	};
}