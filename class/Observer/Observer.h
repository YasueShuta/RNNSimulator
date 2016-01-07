#pragma once
#include <typeinfo.h>

#include "../Abstract/ObjectInitializer.h"
#include "../Abstract/Findable.h"
#include "../Abstract/Node.h"
#include "../Figure/FigureViewer.h"
#include "../Recorder/DataRecorder.h"

namespace RNNSimulator {
	class Observer : public ObjectInitializer, public Findable
	{
	public:
		static int NEXTOBJID;

		int obj_id;

		Node* target;

		bool isValid;
		std::string flag;

		int print_every;
		int plot_every;

		DataRecorder* recorder;
		std::string dstfile;
		std::string dstdir;
		FigureViewer* viewer;

		void* dataptr;
		int datalen;
		template <typename T> T data();

		std::vector<double> xvec;

		virtual void setDefault();
		virtual void reset();
	
		void setId();
		void setTargetData();
		void setViewer();

		void viewTarget();

		Observer() : Observer(0) {};
		Observer(int setvarnum, ...);
		virtual ~Observer();

	protected:
		virtual int set_inner(int argvnum, va_list argv) override;
	};
}

#include "Observer_private.h"