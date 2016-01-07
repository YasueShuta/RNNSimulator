#pragma once
#include "Observer.h"
#include "../Simulator/SimTime.h"

namespace RNNSimulator {
	class TemporalObserver : public Observer {
	public:
		SimTime* time;
		std::vector<double> datavec;

		virtual void setTargetData() override;
		virtual void setXvec() override;
		virtual void viewTarget() override;

		TemporalObserver() : TemporalObserver(0) {};
		TemporalObserver(int varargnum, ...);
		virtual ~TemporalObserver() {};
	};
}