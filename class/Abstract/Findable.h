#pragma once

#include <iostream>
#include <string>

namespace RNNSimulator {
	class Findable
	{
	public:
		Findable();
		virtual ~Findable();

		Findable* next = NULL;
		int id;

		static Findable* ROOT;
		static int NEXTID;

		virtual void hyde() {};
	};

	template <typename T = Findable> void* findObject();
	template <typename T = Findable> void* findObject(int id);

	class SampleFindable : public Findable
	{
	public:
		std::string name;

		SampleFindable() : Findable()
		{
			name = "Sample";
		}
		~SampleFindable()
		{
			std::cout << "Destructor: sample" << std::endl;
		}
	};
}

#include "Findable_private.h""