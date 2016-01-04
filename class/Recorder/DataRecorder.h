#pragma once
#include <string>
#include <fstream>
#include "../Abstract/ObjectInitializer.h"
#include "../Abstract/Findable.h"

namespace RNNSimulator {
	class Observer;

	class DataRecorder : public ObjectInitializer, public Findable {
	public:
		static int NEXTRECID;

		int simId = -1;
		int recordId = -1;
		int file_count = -1;
		int data_count = -1;

		std::string filename;

		bool isValid = false;
		Observer* observer = NULL;
		std::string recordName = "data";


		DataRecorder();
		DataRecorder(std::string recordName_);
		~DataRecorder();

		virtual void reset();
		void setId();
		void recordObserver(Observer* observer_);

	protected:
		virtual int set_inner(int varargnum, va_list argv) override;

	};
}
