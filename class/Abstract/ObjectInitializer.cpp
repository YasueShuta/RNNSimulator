#include "ObjectInitializer.h"
#include <iostream>
#include <string>
#include <sstream>

using namespace RNNSimulator;

ObjectInitializer::ObjectInitializer(std::string argv){
	set(argv);
}

ObjectInitializer::~ObjectInitializer() {

}

int ObjectInitializer::set(std::string argv) {
	if (argv.length() == 0) {
		set_inner();
		return 0;
	}

	std::vector<std::string> vec;
	std::stringstream ss(argv);
	char sep1 = ' ';
	char sep2 = ',';

	std::string buf;
	std::string buf2;

	while (std::getline(ss, buf, sep1)){
		std::stringstream ss2(buf);
		while (std::getline(ss2, buf2, sep2)) {
			vec.push_back(buf2);
		}
	}
	return set(vec);
}

int ObjectInitializer::set(std::vector<std::string> argv) {
	if (argv.size() == 0){
		return set_inner();
	}

	if (argv.size()	% 2 == 1) {
		std::cout << "Invalid Argument (Initializer):" << std::endl;
		return 0;
	}
	else {
		int argvnum;
		std::string buf;

		argvnum = argv.size() / 2;

		std::vector<std::string> argvstr (argvnum);
		std::vector<std::string> argvdata (argvnum);

		for (int i = 0; i < argvnum; i++) {
			buf = argv.at(2 * i);
			if (buf.at(0) == '-') buf = buf.erase(0, 1);
			argvstr[i]+= buf;
			argvdata[i]+= argv.at(2 * i + 1);
		}
		return set_inner(argvnum, argvstr, argvdata);
	}
}
int ObjectInitializer::setvar(int argvnum, ...) {
	va_list argv;
	va_start(argv, argvnum);
	return set_inner(argvnum, argv);
}