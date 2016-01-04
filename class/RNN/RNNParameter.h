#pragma once
#include "../Abstract/ObjectInitializer.h"
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class RNNParameter {
	public:
		int n;
		double p;
		double g;
		double th;

		Eigen::MatrixXd M0;
		Eigen::VectorXd x0;

		bool isPlastic = false;
		bool isLoadedNetwork = false;
		bool isLoadedPotential = false;


		virtual void reset();
		void setDefault();
		
		void setNetwork();
		void setPotential();
		void setPlastic();
		void resetPlastic();

		static void init() { init(64); }
		static void init(int n_,
			double p_ = 0.1,
			double g_ = 1.5,
			double th_ = 1.5,
			std::vector<double> M0_ = std::vector<double>(0),
			std::vector<double> x0_ = std::vector<double>(0));

		RNNParameter();
		~RNNParameter();

	protected:
		virtual int set_inner(int varargnum, va_list argv);
	};
}