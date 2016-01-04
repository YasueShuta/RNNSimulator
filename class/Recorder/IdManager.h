#pragma once
#include <string>
#include <fstream>
#include "../Abstract/Findable.h"
#include "../../RNNSimulator/RNNSimulator/MyPath.h"

namespace RNNSimulator {
	class SetupInfo
	{
	public:
		std::string basedir;
		std::string folder;
		std::string idfile;

		SetupInfo() {};
		SetupInfo(std::string basedir_, std::string folder_, std::string idfile_);
		SetupInfo(std::string filename);
		~SetupInfo() {};

		std::string dirname() const;
		std::string foldername() const;
		std::string idfilename() const;
	};

	class IdInfo
	{
	public:
		int simId;
		int recordId;
		int file_count;
		int data_count;

		std::string id2str();
		static IdInfo str2id(std::string str_);

		IdInfo() {};
		~IdInfo() {};
	};

	class IdManager : public Findable
	{
	private:
		const std::string setupdir = RNNSimulator::SETUPFILE_DIR;
		const std::string setupname = RNNSimulator::SETUPFILE_NAME;

	public:
		SetupInfo setup;
		IdInfo idinfo;

		IdManager();
		~IdManager();

		static IdManager* getObject();
		static SetupInfo getSetup();
		static IdInfo getIdInfo();

		void init();
		void reset();

		void getId(int simId = -1);
		void saveId(IdInfo idinfo);
		void saveId(int simId, std::string idstr);
	};
}
