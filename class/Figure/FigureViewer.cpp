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
		}
		else if (tmp == "offset_y" || tmp == "woffset_y") {
			woffset_y = std::stoi(argvdata.at(i));
		}
		else if (tmp == "xlabel" || tmp == "x") {
			xlabel = argvdata.at(i);
		}
		else if (tmp == "ylabel" || tmp == "y") {
			ylabel = argvdata.at(i);
		}
		else if (tmp == "linewidth" || tmp == "lw") {
			linewidth = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontsize" || tmp == "fs") {
			fontsize = std::stod(argvdata.at(i));
		}
		else if (tmp == "fontsize1" || tmp == "fs1") {
			fontsize1 = std::stod(argvdata.at(i));
		}
		else if (tmp == "font" || tmp == "f") {
			font = argvdata.at(i);
		}
		else if (tmp == "font1" || tmp == "f1") {
			font1 = argvdata.at(i);
		}
	}
	reset();

	return argvnum;
}
int FigureViewer::set_inner(int argvnum, va_list argv) {
	std::string tmp;
	for (int i = 0; i < argvnum; i++) {
		tmp = va_arg(argv, char*);
		if (tmp == "mode") {
			mode = va_arg(argv, int);
		}
		else if (tmp == "flag") {
			flag = va_arg(argv, char*);
		}
		else if (tmp == "terminal") {
			terminal = va_arg(argv, char*);
		}
		else if (tmp == "title") {
			title = va_arg(argv, char*);
		}
		else if (tmp == "size_x" || tmp == "wsize_x") {
			wsize_x = va_arg(argv, int);
		}
		else if (tmp == "size_y" || tmp == "wsize_y") {
			wsize_y = va_arg(argv, int);
		}
		else if (tmp == "offset_x" || tmp == "woffset_x")
		{
			woffset_x = va_arg(argv, int);
		}
		else if (tmp == "offset_y" || tmp == "woffset_y") {
			woffset_y = va_arg(argv, int);
		}
		else if (tmp == "xlabel" || tmp == "x") {
			xlabel = va_arg(argv, char*);
		}
		else if (tmp == "ylabel" || tmp == "y") {
			ylabel = va_arg(argv, char*);
		}
		else if (tmp == "linewidth" || tmp == "lw") {
			linewidth = va_arg(argv, int);
		}
		else if (tmp == "fontsize" || tmp == "fs") {
			fontsize = va_arg(argv, double);
		}
		else if (tmp == "fontsize1" || tmp == "fs1") {
			fontsize1 = va_arg(argv, double);
		}
		else if (tmp == "font" || tmp == "f") {
			font = va_arg(argv, char*);
		}
		else if (tmp == "font1" || tmp == "f1") {
			font1 = va_arg(argv, char*);
		}
	}
	reset();

	return argvnum;
}

Gnuplot::GP* FigureViewer::initFigure() {
	Gnuplot::GP* ret = 0;
	std::string titlestr;
	titlestr = title + " " + std::to_string(figId);
	ret = new Gnuplot::GP(false, "windows", titlestr.c_str(), font, fontsize, wsize_x, wsize_y, woffset_x, woffset_y);
	return ret;
}
void FigureViewer::replaceFigure() {
	std::stringstream ss;
	ss << "set terminal " << terminal;
	if (title.length() > 0)
		ss << " title '" << title << " " << figId << "'";
	ss << " font '" << font << "," << fontsize << "'";
	ss << " size " << wsize_x << "," << wsize_y;
	ss << " position " << woffset_x << "," << woffset_y;

	fig->hwrite(ss.str());

}

void FigureViewer::plot(std::string arg_) {
	fig->plotFunc(arg_, linewidth);
}
void FigureViewer::plot(std::string arg_, int linecolor_, std::string title_) {
	fig->plotFunc(arg_, linewidth, linecolor_, title_);
}
void FigureViewer::plot(std::string arg_, std::string linecolor_, std::string title_) {
	fig->plotFunc(arg_, linewidth, linecolor_, title_);
}

void FigureViewer::plot_data(std::vector<double> xvec_, std::vector<double> yvec_, std::string linecolor_, std::string title_) {
	fig->plotVec2(xvec_, yvec_, linewidth, linecolor_);
}
void FigureViewer::plot_datavar(int datanum_, std::vector<std::string> linecolors_, std::vector<std::string> titles_, ...) {
	va_list vl;
	va_start(vl, titles_);
	std::vector<double> xvec;
	std::vector<std::vector<double>> yvec = std::vector<std::vector<double>>(datanum_);
	xvec = va_arg(vl, std::vector<double>);
	for (int i = 0;i < datanum_;i++) {
		yvec.at(i) = va_arg(vl, std::vector<double>);
	}
	if (datanum_ == 1) {
		fig->plotVec2(xvec, yvec.at(1), linewidth, linecolors_.at(1));
	}
	else {
		fig->plotVec2Multi(xvec, yvec, linewidth, linecolors_, titles_);
	}
}

void FigureViewer::setLabel(std::string cmd_, std::string label_, double fontsize_, std::string font_) {
	if (fontsize_) fontsize_ = fontsize1;
	if (font_.length() == 0) font_ = font1;
	std::stringstream ss;
	ss << "set " << cmd_ << "label '" << label_ << "'";
	ss << " font '" << font_ << "," << fontsize_ << "'";
	std::cout << ss.str() << std::endl;
	fig->hwrite(ss.str());
}

void FigureViewer::reset() {
	if (fig == NULL) {
		fig = initFigure();
	}
	else {
		replaceFigure();
	}
	setLabel("x", xlabel);
	setLabel("y", ylabel);
}

void FigureViewer::setDefault(){
	terminal = "windows";
	title = "Figure";
	wsize_x = 640;
	wsize_y = 330;
	woffset_x = 30;
	woffset_y = 30;

	xlabel = "X";
	ylabel = "Y";

	linewidth = 3;
	fontsize = 16;
	fontsize1 = 18;
	font = "Times New Roman";
	font1 = "Segoe UI";
}

// void registerObserver(Observer* obs)

// FigureViewer* FigureViewer::init(Observer* obs)
