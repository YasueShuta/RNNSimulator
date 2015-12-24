#pragma once
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

namespace Gnuplot {

	class Handle
	{
	private:
		FILE* fp;

		void send();
	public:
		const char* GNUPLOT_EXE = "C:/gnuplot/bin/gnuplot.exe";
		std::stringstream buf;

		Handle();
		~Handle();
		void write();
		void write(std::string s);
		void write(const char* s);
		void dispBuf();
	};

	class GP
	{
	private:
		Handle* h;
	public:
		void setTitle(const char* title_);
		void setTitle(const char* title_, int fontsize_);
		void setTitle(const char* title_, const char* font_);
		void setTitle(const char* title_, const char* font_, int fontsize);

		void setXLabel();

		void setYLabel();

		void setKey();

//		void plotFunc();
//		void plotVec1();
//		void plotVec2();

		void replot();

		GP();
		~GP();
	};
}


