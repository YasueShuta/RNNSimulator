#pragma once
#include <string>

class ObjectManager
{
public:
	ObjectManager();
	~ObjectManager();

	ObjectManager* parent = 0;
	virtual void hyde() {};

	static ObjectManager* findObject(std::string classname = "ObjectManager");
};

class ObjectManagerStore
{
public:
	ObjectManagerStore() {};
	~ObjectManagerStore() {};

	static ObjectManager* root;
	static int num;

	static void add(ObjectManager*);
	static void del(ObjectManager*);
};


class SampleManager : public ObjectManager
{
public:
	std::string name;

	SampleManager() : ObjectManager()
	{
		name = "Sample";
	}
};