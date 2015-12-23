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
		virtual void inflow(std::vector<double> flow);
		virtual void inflow(Eigen::VectorXd flow);

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
		~SampleConnectable() {};

		int outflow_len() override {
			return o_len;
		}
		int inflow_len() override {
			return i_len;
		}

		/*
		std::vector<double> outflow() override {
			std::vector<double> ret(outflow_len(), 0);
			return ret;
		}
		*/
		Eigen::VectorXd outflow() override {
			Eigen::VectorXd ret = Eigen::VectorXd::Random(outflow_len());
			return ret;
		}
		void inflow(std::vector<double> flow) override {
		}
		void inflow(Eigen::VectorXd flow) override {
		}
	};
}