#pragma once
#include "../Abstract/ObjectInitializer.h"
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class Connector;

	class RLSParameter : public ObjectInitializer
	{
	public:
		double alpha;
		double r_alpha;
		int learn_every;

//		int col;
//		int row;

		RLSParameter();
		RLSParameter(std::string argv);
		RLSParameter(int varargnum, ...);
		RLSParameter(int varargnum, va_list argv);
		~RLSParameter();

		void setDefault();
		virtual void reset() override;
	protected:
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
		virtual int set_inner(int varargnum, va_list argv);
	};
}