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
//		ifs >> "Base directory: " >> basedir;
//		ifs >> "Folder name: " >> folder;
	}
}

std::string SetupInfo::dirname() const {
	return basedir;
}

std::string SetupInfo::foldername() const {
	std::string ret;
	return basedir + "\\" + folder;
}


IdInfo::IdInfo() {};
IdInfo::~IdInfo() {};


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

void IdManager::init() {
	std::ofstream ofs;

}
void IdManager::reset() {

}

void IdManager::getId() {

}
void IdManager::saveId() {

}