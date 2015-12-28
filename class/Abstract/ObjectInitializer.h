#pragma once
#include "MyObject.h"
#include <iostream>
#include <vector>
#include <string>
#include <stdarg.h>

namespace RNNSimulator {

	class ObjectInitializer
	{
	public:
		ObjectInitializer() : ObjectInitializer("") {};
		ObjectInitializer(std::string argv);
		virtual ~ObjectInitializer();

		virtual void hyde() {};
		virtual void reset() {};
		virtual int set(std::string argv) final;
		virtual int set(std::vector<std::string> argv) final;
		virtual int set(int setvarnum, ...) final; // use stdarg.h, va macro setvar(2, "arg1", arg1, "arg2", arg2)

	protected:
		virtual int set_inner() {
			reset();
			return 0;
		}
		virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
			reset();
			return 0;
		}
		virtual int set_inner(int argvnum, va_list argv) {
			reset();
			return 0;
		}
	};


	class SampleInitializer : public ObjectInitializer
	{
	public:
		int id = 0;
		char name[30] = "init";
		double data = 0;
		void* ptr = NULL;

	protected:
		virtual int set_inner() override {
			return 0;
		}
		virtual int	set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override {
			std::string arg;
			for (int i = 0;i < argvnum; i++) {
				arg = argvstr.at(i);
				std::cout << i <<
					": " << arg <<
					": " << argvdata.at(i) << std::endl;
				if (std::strcmp(arg.c_str(), "id") == 0) {
					sscanf_s(argvdata.at(i).c_str(), "%d", &id);
				}
				else if (std::strcmp(arg.c_str(), "name") == 0) {
					strcpy_s(name, 30, argvdata.at(i).c_str());
				}
				else if (std::strcmp(arg.c_str(), "data") == 0) {
					sscanf_s(argvdata.at(i).c_str(), "%lf", &data);
				}
			}
			return argvnum;
		}
		virtual int set_inner(int setvarnum, va_list argv) {
			std::string arg;
			for (int i = 0;i < setvarnum;i++) {
				arg = va_arg(argv, char*);
				std::cout << i << ": " << arg;
				if (std::strcmp(arg.c_str(), "id") == 0) {
					int id_ = va_arg(argv, int);
					std::cout << ": " << id_ << std::endl;
					id = id_;
				}
				else if (std::strcmp(arg.c_str(), "name") == 0) {
					char* str;
					str = va_arg(argv, char*);
					std::cout << ": " << str << std::endl;
					strcpy_s(name, str);
				}
				else if (std::strcmp(arg.c_str(), "data") == 0) {
					double data_ = va_arg(argv, double);
					std::cout << ": " << data_ << std::endl;
					data = data_;
				}
				else if (std::strcmp(arg.c_str(), "ptr") == 0) {
					void* ptr_ = va_arg(argv, void*);
					std::cout << ": " << ptr_ << std::endl;
					ptr = ptr_;
				}
			}
			return setvarnum;
		}
	};

}