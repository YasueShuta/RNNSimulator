#pragma once
#include <string>
#include "../Abstract/Findable.h"
#include "../../RNNSimulator/RNNSimulator/MyPath.h"

namespace RNNSimulator {
	class SetupInfo
	{
	public:
		std::string basedir;
		std::string folder;
//		std::string idfile;

		SetupInfo() {};
		SetupInfo(std::string basedir_, std::string folder_, std::string idfile_);
		~SetupInfo() {};
	};

	class IdInfo
	{
	public:
		IdInfo() {};
		IdInfo() {};
	};

	class IdManager : public Findable
	{
	private:
		const std::string setupdir = RNNSimulator::SETUPFILE_DIR;
		const std::string setupname = RNNSimulator::SETUPFILE_NAME;

	public:
		static IdManager* getObject();
		static SetupInfo getSetup();

		void init();
		void reset();

		void getId()
	};
}
