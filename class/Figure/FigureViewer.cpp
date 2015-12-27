#include "FigureViewer.h"

using namespace RNNSimulator;

int FigureViewer::nextId = 0;

FigureViewer::FigureViewer()
{
	mode = 0;
	flag = "initialize";
	n_fig = 0;
	n_obs = 0;
	id = nextId;

	nextId += 1;

	reset();
}

FigureViewer::~FigureViewer()
{
	_pclose(pFig);
}

int FigureViewer::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	for (int i = 0; i < argvnum; i++) {
		std::string tmp = argvstr.at(i);
		if (tmp == "mode") {
			mode = std::stoi(argvdata.at(i));
		}
		else if (tmp == "flag") {
			flag = (char*)argvdata.at(i).c_str();
		}
		else if (tmp == "linewidth" || tmp == "lw") {
			linewidth = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontsize" || tmp == "fs") {
			fontsize = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontweight" || tmp == "fw") {
			fontweight = (char*)argvdata.at(i).c_str();
		}
	}
	reset();

	return argvnum;
}
int FigureViewer::set_inner(int argvnum, va_list argv) {
	std::string arg;
	for (int i = 0; i < argvnum; i++) {
		arg = va_arg(argv, char*);
		if (arg == "mode") {
			mode = va_arg(argv, int);
		}
		else if (arg == "flag") {
			flag = va_arg(argv, char*);
		}
		else if (arg == "linewidth" || arg == "lw") {
			linewidth = va_arg(argv, double);
		}
		else if (arg == "fontsize" || arg == "fs") {
			fontsize = va_arg(argv, double);
		}
		else if (arg == "fontweight" || arg == "fw") {
			fontweight = va_arg(argv, char*);
		}
	}
	reset();

	return argvnum;
}

void FigureViewer::reset() {
	if (pFig == NULL) {
		//		pFig = initFigure();
	}
}

void FigureViewer::setDefault(){
	linewidth = 3;
	fontsize = 20;
	fontweight = "bold";
}

// void registerObserver(Observer* obs)

// FigureViewer* FigureViewer::init(Observer* obs)
