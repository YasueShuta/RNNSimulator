#pragma once
#include <vector>
#include <string>
#include "..\Abstract\ObjectInitializer.h"
#include "../Abstract/Findable.h"
#include "../gnuplotInterface/Gnuplot.h"
#include <stdarg.h>

namespace RNNSimulator {
	class FigureViewer :
		public ObjectInitializer, public Findable
	{
	public:
		int mode;
		std::string flag;
		int figId;
		static int NEXTFIGID;

		Gnuplot::GP* fig;
		int n_fig;

		std::string terminal;
		std::string title;
		int wsize_x;
		int wsize_y;
		int woffset_x;
		int woffset_y;

		double linewidth;
		double fontsize;
		std::string fontweight;

		int layout_x;
		int layout_y;
		int layout_i;

		// std::vector<Observer*> observers;
		int n_obs;

		FigureViewer() : FigureViewer("") {};
		FigureViewer(std::string argv);
		~FigureViewer();

		Gnuplot::GP* initFigure();
		void replaceFigure();

		void plot(std::string arg_);
		void plot(std::string arg_, int linecolor_, std::string title_ = "");
		void plot(std::string arg_, std::string linecolor_, std::string title_ = "");
		void plot_data(std::vector<double> xvec_, std::vector<double> yvec_, std::string linecolor_ = "blue", std::string title_ = "");
		void plot_datavar(int datanum,
			std::vector<std::string> linecolors_,
			std::vector<std::string> titles_, ...);

		void reset() override;
		void setDefault();
//		void registerObserver(Observer* obs);
//		static FigureViewer* init(Observer* obs);


	protected:
		int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
		int set_inner(int argvnum, va_list argv);
	};

}