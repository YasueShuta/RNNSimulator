#include "FigureViewer.h"

using namespace RNNSimulator;

#ifndef _FIGUREVIEWER_CPP
#define _FIGUREVIEWER_CPP
int FigureViewer::NEXTFIGID = 0;
#endif


FigureViewer::FigureViewer(std::string argv)
{
	mode = 0;
	flag = "initialize";
	n_fig = 0;
	n_obs = 0;

	figId = NEXTFIGID;
	NEXTFIGID += 1;

	setDefault();
	set(argv);
}

FigureViewer::~FigureViewer()
{
}

int FigureViewer::set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
	for (int i = 0; i < argvnum; i++) {
		std::string tmp = argvstr.at(i);
		std::cout << "Arg: " << tmp << " | " << argvdata.at(i) << std::endl;
		if (tmp == "mode") {
			mode = std::stoi(argvdata.at(i));
		}
		else if (tmp == "flag") {
			flag = argvdata.at(i);
		}
		else if (tmp == "terminal") {
			terminal = argvdata.at(i);
		}
		else if (tmp == "title") {
			title = argvdata.at(i);
		}
		else if (tmp == "size_x" || tmp == "wsize_x") {
			wsize_x = std::stoi(argvdata.at(i));
		}
		else if (tmp == "size_y" || tmp == "wsize_y") {
			wsize_y = std::stoi(argvdata.at(i));
		}
		else if (tmp == "offset_x" || tmp == "woffset_x")
		{
			woffset_x = std::stoi(argvdata.at(i));
			std::cout << "Set offset_x: " << woffset_x << std::endl;
		}
		else if (tmp == "offset_y" || tmp == "woffset_y") {
			woffset_y = std::stoi(argvdata.at(i));
			std::cout << "Set offset_y: " << woffset_y << std::endl;
		}
		else if (tmp == "linewidth" || tmp == "lw") {
			linewidth = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontsize" || tmp == "fs") {
			fontsize = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontweight" || tmp == "fw") {
			fontweight = argvdata.at(i);
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

Gnuplot::GP* FigureViewer::initFigure() {
	Gnuplot::GP* ret = 0;
	std::string titlestr;
	titlestr = title + " " + std::to_string(figId);
	std::cout << titlestr << std::endl;	
	std::cout << "title: " << titlestr << std::endl;
	std::cout << "size x,y: " << wsize_x << "," << wsize_y << std::endl;
	std::cout << "position x,y: " << woffset_x << "," << woffset_y << std::endl;
	ret = new Gnuplot::GP(false, "windows", titlestr.c_str(), wsize_x, wsize_y, woffset_x, woffset_y);
	return ret;
}
void FigureViewer::replaceFigure() {
	std::stringstream ss;
	ss << "set terminal " << terminal;
	if (title.length() > 0)
		ss << " title '" << title << " " << figId << "'";
	ss << " size " << wsize_x << "," << wsize_y;
	ss << " position " << woffset_x << "," << woffset_y;

	fig->hwrite(ss.str());

}

void FigureViewer::reset() {
	if (fig == NULL) {
		fig = initFigure();
	}
	else {
		replaceFigure();
	}
}

void FigureViewer::setDefault(){
	terminal = "windows";
	title = "Figure";
	wsize_x = 640;
	wsize_y = 330;
	woffset_x = 30;
	woffset_y = 30;

	linewidth = 3;
	fontsize = 20;
	fontweight = "bold";
}

// void registerObserver(Observer* obs)

// FigureViewer* FigureViewer::init(Observer* obs)
