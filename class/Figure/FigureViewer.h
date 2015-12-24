#pragma once
#include <vector>
#include <string>
#include "..\Abstract\ObjectInitializer.h"

namespace RNNSimulator {
	class FigureViewer :
		public ObjectInitializer
	{
	public:
		int mode;
		char* flag;
		int id;
		static int nextId;

		FILE* pFig;
		int n_fig;

		double linewidth;
		double fontsize;
		char* fontweight;

		int layout_x;
		int layout_y;
		int layout_i;

		// std::vector<Observer*> observers;
		int n_obs;

		FigureViewer();
		FigureViewer(std::string argv) : FigureViewer() {
			set(argv);
		}
		~FigureViewer();
		void reset();
		void setDefault();
//		void registerObserver(Observer* obs);
//		static FigureViewer* init(Observer* obs);


	protected:
		int set_inner() override {
			return ObjectInitializer::set_inner();
		}
		int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
	};

}