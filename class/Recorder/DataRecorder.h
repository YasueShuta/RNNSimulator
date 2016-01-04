#pragma once
#include <string>
#include <fstream>
#include <time.h>
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

		void print(std::string str_, std::string filename_ = filename);
		void initfile();
		void save(std::string str_, std::string name_, std::string dir_);
		std::string timeStr();
		

	protected:
		virtual int set_inner(int varargnum, va_list argv) override;

	};
}
