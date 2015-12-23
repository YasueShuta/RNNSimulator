#pragma once
#include <vector>
#include <string>
#include "..\Abstract\ObjectManager.h"
#include "..\Abstract\ObjectInitializer.h"
#include "FigureViewer.h"

namespace RNNSimulator {
	class FigureManager :
		public ObjectManager, public ObjectInitializer
	{
	public:
		std::vector< RNNSimulator::FigureViewer* > id;
		int nextId;

		std::vector<std::string> colorSet;
		int colorSetNum;


		FigureManager();
		~FigureManager();

		void reset();
		void setDefault();

		static ObjectManager* getObject();
		static int getId(FigureViewer*);

	protected:
		int set_inner() override {
			ObjectInitializer::set_inner();
		}
		int set_inner(int argvnum, std::vector<std::string> argvstr, std::vector<std::string> argvdata) override;
	};
}