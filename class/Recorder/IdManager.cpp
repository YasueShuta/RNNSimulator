#include "IdManager.h"

using namespace RNNSimulator;

SetupInfo::SetupInfo(std::string basedir_, std::string folder_) {
	basedir = basedir_;
	folder = folder_;
}

SetupInfo::SetupInfo(std::string filename_) {
	std::ifstream ifs(filename_.c_str());
	std::string buf;

	if (ifs.fail()) {
		std::cout << "Error: File could not open" << std::endl;
	}
	else {
		ifs >> buf; // skip pre-space sentense
		ifs >> basedir;
		ifs >> buf; // skip pre-space sentense
		ifs >> folder;
//		ifs >> "BaseDirectory: " >> basedir;
//		ifs >> "FolderName: " >> folder;
	}
}

std::string SetupInfo::dirname() const {
	return basedir;
}

std::string SetupInfo::foldername() const {
	std::string ret;
	return basedir + "\\" + folder;
}


//IdInfo::IdInfo() {}
//IdInfo::~IdInfo() {}


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
IdInfo IdManager::getIdInfo() {
	IdManager* im = getObject();
	IdInfo* ret = new IdInfo();
	return *ret;
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
}
void IdManager::reset() {
	init();
	setup = getSetup();
	idinfo = getIdInfo();
}

void IdManager::getId() {

}
void IdManager::saveId() {

}