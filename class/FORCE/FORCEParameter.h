#pragma once
#include "../Abstract/ObjectInitializer.h"
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class Connector;

	class FORCEParameter : public ObjectInitializer
	{
	public:
		double alpha;
		double r_alpha;
		int learn_every;

		int col;
		int row;

		FORCEParameter();
		~FORCEParameter();

		void setDefault();
		virtual void reset() override;
	protected:
		virtual int set_inner() override;
	};
}