#pragma once
#include "FORCEPlasticity.h"
#include "../Connector/ConnectableNode.h"
#include "../Connector/Connector.h"

namespace RNNSimulator {
	class FORCEModule : public Connector, public FORCEPlasticity {
	public:
		FORCEModule(Connectable* in, Connectable* out);
		FORCEModule(Connectable* in, Connectable* out, int option);
		FORCEModule(Connectable* in, Connectable* out, std::vector<double> w);
		virtual ~FORCEModule();

		void update();
	};
}