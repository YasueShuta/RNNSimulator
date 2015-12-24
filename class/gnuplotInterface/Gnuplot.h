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


}

