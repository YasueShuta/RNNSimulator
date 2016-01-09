#pragma once
#include "RLSPlasticity.h"
#include "../Connector/ConnectableNode.h"
#include "../Connector/Connector.h"

namespace RNNSimulator {
	class RLSModule : public Connector, public RLSPlasticity {
	public:
		RLSModule(int mode_, Connectable* in, Connectable* out);
		RLSModule(int mode_, Connectable* in, Connectable* out, int option);
		RLSModule(int mode_, Connectable* in, Connectable* out, std::vector<double> w);
		virtual ~RLSModule();

		void update();
	};
}