#pragma once

#include <vector>
#include "../Abstract/Findable.h"
#include "../Abstract/ObjectInitializer.h"
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class Node : public ObjectInitializer
	{
	public:
		int mode;
		Eigen::VectorXd potential;
		Eigen::VectorXd readout;

		int cellNum;

		Node();
		Node(std::string argv);
		Node(int setvarnum, ...);
		virtual ~Node();

		void setDefault();
		void reset();
		std::vector<double> to_vec(Eigen::VectorXd);

		virtual void update();
		void tanh_read();

	protected:
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
		virtual int set_inner(int argvnum, va_list argv) override;
	};
}

