#pragma once
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <Windows.h>

namespace Gnuplot {

	class Handle
	{
	private:
		FILE* fp;

		void send();
		void setId();
	public:
		static int NEXTID;
		static Handle* HEAD;

		int id;
		Handle* nextHandle;
		const char* GNUPLOT_EXE = "C:/gnuplot/bin/gnuplot.exe";
		std::stringstream buf;

		Handle(const char* options_ = "");
		~Handle();
		void write();
		void write(std::string s);
		void write(const char* s);
		void dispBuf();
		void resetBuf();

		static Handle* findHandle(int id_);
	};

	class GP
	{
	private:
		Handle* h;

	public:
		void hwrite() { h->write(); };
		void hwrite(const char* s) { h->write(s); };
		void hwrite(std::string s) { h->write(s); };
		int getId() { return h->id; };

//		void plotFunc();
//		void plotVec1();
		void plotVec2(std::vector<double> xdata_, std::vector<double> ydata_, const char* option_ = "");
		void plotVec2Multi(std::vector<double> xdata_, std::vector<std::vector<double>> ydataarray_, std::vector<const char*> optionarray_ = std::vector<const char*>(0));
		void plotVec2(double* xdata_, double* ydata_, int len_, const char* option_ = "");
		void plotVec2Multi(double* xdata_, int len_, double* ydataarray_[], int ynum, const char* optionarray_[] = NULL);


		static void replotAll();

		GP();
		GP(const char* option_);
		GP(int id);
		GP(Handle* h_);
		GP(
			bool isPOption_,
			const char* terminal_ = "windows",
			const char* title_ = "",
			int wsize_x_ = 640,
			int wsize_y_ = 330,
			int woffset_x_ = 30,
			int woffset_y_ = 30,
			const char* file_ = "");
		~GP();
	};
}


