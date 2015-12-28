#pragma once
#include <string>
#include "../Abstract/Findable.h"

namespace RNNSimulator {
	class IdManager : public Findable
	{
	private:
		const std::string setupfile = "C:/Users/mech-user/Documents/Visual Studio 2015/Projects/RNNSimulator/record/setup.dat";

	public:
		//		static IdManager* getObject();
		//		static char* getSetup();
	};

	class IdInfo
	{
	public:
		std::string basedir;
		std::string folder;
		std::string idfile;
	};
}
