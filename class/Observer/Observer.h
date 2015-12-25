#pragma once
#include "../Abstract/ObjectInitializer.h"
#include "../Abstract/Node.h"
#include "../Figure/FigureViewer.h"

namespace RNNSimulator {
	class Observer : public ObjectInitializer
	{
	public:
		static int NEXTID;
		static Observer* HEAD;

		int id;
		Observer* nextObserver;

		Node* target;

		bool isValid = false;
		char* flag = "initialize";

		int print_every = 100;
		int plot_every = 1000;

		// DataRecorder* recorder;
		char* dstfile;
		char* dstdir;
		FigureViewer* viewer;

		std::vector<double> datavec;


		void setId();

		Observer();
		~Observer();

	protected:
		virtual int set_inner() override {
			return 0;
		};
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
	};
}

