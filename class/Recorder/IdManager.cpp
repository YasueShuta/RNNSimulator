#include "IdManager.h"

using namespace RNNSimulator;

SetupInfo::SetupInfo(std::string basedir_, std::string folder_, std::string idfile_) {
	basedir = basedir_;
	folder = folder_;
	idfile = idfile_;
}

SetupInfo::SetupInfo(std::string filename_) {
	std::ifstream ifs(filename_.c_str());
	std::string buf;

	if (ifs.fail()) {
		std::cout << "Error: File could not open" << std::endl;
		return;
	}
	
	ifs >> buf; // skip pre-space sentense
	ifs >> basedir;
	ifs >> buf; // skip pre-space sentense
	ifs >> folder;
//	ifs >> buf;	
//	ifs >> idfile;
//	ifs >> buf;
//	ifs >> simIdNum;
}

std::string SetupInfo::dirname() const {
	return basedir;
}
std::string SetupInfo::foldername() const {
	std::string ret;
	return basedir + "\\" + folder;
}
std::string SetupInfo::idfilename() const {
	std::string ret;
	return basedir + "\\" + folder + "\\" + idfile;
}

//IdInfo::IdInfo() {}
//IdInfo::~IdInfo() {}
std::string IdInfo::id2str() {
	std::string ret;
	ret = std::to_string(simId);
	ret += " " + std::to_string(recordId);
	ret += " " + std::to_string(file_count);
	ret += " " + std::to_string(data_count);
	return ret;
}
IdInfo IdInfo::str2id(std::string str_) {
	IdInfo* ret = new IdInfo();
	int tmp0, tmp1, tmp2, tmp3;
	sscanf_s(str_.c_str(), "%d %d %d %d", &tmp0, &tmp1, &tmp2, &tmp3);
	ret->simId = tmp0;
	ret->recordId = tmp1;
	ret->file_count = tmp2;
	ret->data_count = tmp3;
	return *ret;
}

IdManager::IdManager() {
	reset();
}
IdManager::~IdManager() {}

IdManager* IdManager::getObject() {
	IdManager* ret;
	ret = findObject<IdManager>();
	if (ret == NULL) {
		ret = new IdManager();
	}
	return ret;
}
SetupInfo IdManager::getSetup() {
	IdManager* im = getObject();
	std::string str;
	str = im->setupdir + "\\" + im->setupname;
	SetupInfo ret(str);
	return ret;
}
IdInfo IdManager::getIdInfo(int simId) {
	IdManager* im = getObject();
	SetupInfo si = im->getSetup();
	return im->loadId(simId); 
}

void IdManager::init() {
	std::string str, cmd;
	str = setupdir + "\\" + setupname;
	std::ofstream ofs(str.c_str());
	ofs << "BaseDirectory: " << str << std::endl;
	cmd = "mkdir " + setupdir + " > NUL 2>&1";
	system(cmd.c_str());
	ofs << "FolderName: " << "testFile";
	cmd = "mkdir " + setupdir + "\\" + "testFile";
	cmd = cmd + " > NUL 2>&1";
	system(cmd.c_str());
	ofs << std::endl;
	ofs << "IdFileName: " << "id.txt";

}
void IdManager::reset() {
	init();
	setup = getSetup();
	simIdNum = setup.simIdNum;
	idinfo = getIdInfo();
}


IdInfo IdManager::initId() {
	std::string filename = getSetup().idfilename();
	std::ofstream ofs;
	IdInfo* ret = new IdInfo();
	std::string str;

	if (simIdNum < 0) {
		// id file is empty
		simIdNum = 0;
	}

	ret->simId = simIdNum;
	simIdNum += 1;
	ret->recordId = 0;
	ret->file_count = 0;
	ret->data_count = 0;

	return *ret;

}
IdInfo IdManager::loadId(int simId) {
	std::string filename = getSetup().idfilename();
	IdInfo* ret = new IdInfo();
	
	return *ret;
}
void IdManager::saveId(IdInfo idinfo) {

}
void IdManager::saveId(int simId, std::string idstr) {

}