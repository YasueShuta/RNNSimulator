#pragma once
#include "../Abstract/ObjectInitializer.h"
#include "../../../eigen/Eigen/core"

namespace RNNSimulator {
	class RNNParameter : public ObjectInitializer {
	public:
		int n;
		double p;
		double g;
		double th;

		Eigen::MatrixXd M0;
		Eigen::VectorXd x0;

		bool isPlastic = false;
		bool isLoadedNetwork = false;
		std::string loadnetname;
		bool isLoadedPotential = false;
		std::string loadxname;


		virtual void reset();
		void setDefault();
		
		void setNetwork();
		void setPotential();
		void setPlastic();
		void resetPlastic();

		static RNNParameter* init() { init(-1); }
		static RNNParameter* init(int n,
			double p_ = -1,
			double g_ = -1,
			double th_ = -1,
			std::string loadnetname_ = "",
			std::string loadxfilename_ = "");
		RNNParameter();
		RNNParameter(std::string argv);
		RNNParameter(int varargnum, ...);
		RNNParameter(int varargnum, va_list argv);
		~RNNParameter();

	protected:
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
		virtual int set_inner(int varargnum, va_list argv) override;
	};
}