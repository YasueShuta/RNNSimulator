#pragma once
#include "FORCEPlasticity.h"
#include "../Connector/ConnectableNode.h"
#include "../Connector/Connector.h"

namespace RNNSimulator {
	class FORCEModule : public Connector, public FORCEPlasticity {
	public:
		FORCEModule();
		~FORCEModule();
	};
}