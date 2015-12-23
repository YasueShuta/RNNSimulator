#pragma once
#include "MyObject.h"
#include <iostream>
#include <vector>
#include <string>

ref class ObjectInitializer
{
public:
	ObjectInitializer();
	~ObjectInitializer();

	virtual void hyde() {};
	int set(std::string argv);
	int set(std::vector<std::string> argv);
protected:
	virtual int set_inner() {
		return 0;
	}
	virtual int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) {
		return 0;
	}
};


ref class SampleInitializer : public ObjectInitializer
{
protected:
	virtual int set_inner() override {
		return 0;
	}
	virtual int	set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override {
		for (int i = 0;i < argvnum; i++) {
			std::cout << i <<
				": " << argvstr.at(i) <<
				": " << argvdata.at(i) << std::endl;
		}
		return argvnum;
	}
};