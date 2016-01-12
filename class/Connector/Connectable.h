#pragma once
#include <vector>
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class Connectable
	{
	public:
		bool isConnectableObject = true;
		bool isConnectable = true;

		virtual int outflow_len();
		virtual int inflow_len();
//		virtual std::vector<double> outflow();
		virtual Eigen::VectorXd outflow();
		virtual void inflow(std::vector<double> flow, int option=0);
		virtual void inflow(Eigen::VectorXd flow, int option=0);

		Connectable() {};
		~Connectable() {};
	};

	class SampleConnectable : public Connectable
	{
	public:
		int o_len;
		int i_len;

		SampleConnectable() : SampleConnectable(1, 1) {};
		SampleConnectable(int in, int out) {
			o_len = out;
			i_len = in;
		};
		virtual ~SampleConnectable() {};

		virtual int outflow_len() override {
			return o_len;
		}
		virtual int inflow_len() override {
			return i_len;
		}

		/*
		std::vector<double> outflow() override {
			std::vector<double> ret(outflow_len(), 0);
			return ret;
		}
		*/
		virtual Eigen::VectorXd outflow() override {
			Eigen::VectorXd ret = Eigen::VectorXd::Random(outflow_len());
			return ret;
		}
		virtual void inflow(std::vector<double> flow, int option=0) override {
		}
		virtual void inflow(Eigen::VectorXd flow, int option=0) override {
		}
	};
}