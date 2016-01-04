#include "DataRecorder.h"

using namespace RNNSimulator;
#ifndef _DATARECORDER_CPP_
#define _DATARECORDER_CPP_
int DataRecorder::NEXTRECID = 0;
#endif

DataRecorder::DataRecorder() : DataRecorder("") {};
DataRecorder::DataRecorder(std::string recordName_) {
	if (recordName_.length() > 0) {
		recordName = recordName_;
	}
	reset();
	isValid = true;
}
DataRecorder::~DataRecorder() {}

void DataRecorder::reset() {
	if (simId < 0) setId();
}
void DataRecorder::setId() {
	if (simId >= 0) return;
	// read simulation id from idfile

	// set recordId and increment NEXTRECID
	if (recordId < 0) {
		recordId = NEXTRECID;
		NEXTRECID += 1;
	}
}
void DataRecorder::recordObserver(Observer* observer_) {
	observer = observer_;
}

int DataRecorder::set_inner(int varargnum, va_list argv) {
	std::string str;
	for (int i = 0;i < varargnum;i++) {
		str = va_arg(argv, char*);
		if (str == "observer" || str == "obs" || str == "o") {
			recordObserver(va_arg(argv, Observer*));
		}
		else if (str == "recordName" || str == "name" || str == "n") {
			recordName = va_arg(argv, char*);
		}
	}
	reset();
	return varargnum;
}