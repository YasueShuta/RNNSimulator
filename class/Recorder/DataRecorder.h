#pragma once
#include <string>
#include <fstream>
#include "../Abstract/ObjectInitializer.h"
#include "../Abstract/Findable.h"

namespace RNNSimulator {
	class Observer;

	class DataRecorder : public ObjectInitializer, public Findable {
	public:
		int simId;
		int recordId;
		int file_count;
		int data_count;

		std::string filename;

		bool isValid = false;
		Observer* observer = NULL;
		std::string recordName = "data";


		DataRecorder();
		DataRecorder(std::string recordName_);
		~DataRecorder();

		virtual void reset();
		void setId();
		void recorderObserver(Observer observer_);

	protected:
		virtual int set_inner(int varargnum, va_list argv) override;

	};
}
