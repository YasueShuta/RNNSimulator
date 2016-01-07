#pragma once
#include "Observer.h"
#include "../Simulator/SimTime.h"

namespace RNNSimulator {
	class TemporalObserver : public Observer {
	public:
		virtual void reset() override;

		TemporalObserver() : TemporalObserver(0) {};
		TemporalObserver(int varargnum, ...);
		~TemporalObserver() {};
	};
}