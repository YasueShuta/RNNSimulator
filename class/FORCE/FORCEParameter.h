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

//		int col;
//		int row;

		FORCEParameter();
		FORCEParameter(std::string argv);
		FORCEParameter(int varargnum, ...);
		FORCEParameter(int varargnum, va_list argv);
		~FORCEParameter();

		void setDefault();
		virtual void reset() override;
	protected:
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
		virtual int set_inner(int varargnum, va_list argv);
	};
}