#include "ObjectManager.h"
#include <iostream>
#include <typeinfo.h>


ObjectManager* ObjectManagerStore::root = new ObjectManager();
int ObjectManagerStore::num = -1;

ObjectManager::ObjectManager()
{
	ObjectManagerStore::add(this);
}

ObjectManager::~ObjectManager()
{
	ObjectManagerStore::del(this);
}

ObjectManager* ObjectManager::findObject(std::string classname){
	std::string buf = "class " + classname;
	ObjectManager* curr = ObjectManagerStore::root;
	for (int i = 0;i < ObjectManagerStore::num; i++) {
		if (strcmp(typeid(*curr->parent).name(), buf.c_str()) == 0) return curr->parent;
		curr = curr->parent;
	}
	return NULL;
}

void ObjectManagerStore::add(ObjectManager* obj)
{
	ObjectManager* tmp;
	if (ObjectManagerStore::num >= 0) {
		tmp = ObjectManagerStore::root->parent;
		ObjectManagerStore::root->parent = obj;
		obj->parent = tmp;
	}
	ObjectManagerStore::num += 1;
}

void ObjectManagerStore::del(ObjectManager* obj)
{
	ObjectManager* curr = ObjectManagerStore::root;
	for (int i = 0;i < ObjectManagerStore::num; i++)
	{
		if (curr->parent == NULL || curr->parent == obj) break;
		curr = curr->parent;
	}
	if (curr->parent == obj) {
		curr->parent = obj->parent;
		ObjectManagerStore::num -= 1;
	}
}
/*
%OBJECTMANAGER Interface for Manager
    
    properties
    end
    
    methods (Static)
        function ret = findObjects(classname)
            if nargin == 0
                classname = 'ObjectManager';
            end
            list = evalin('base', 'whos');
            ret = {};
            j = 1;
            for i = 1:length(list)
                if strcmp(classname, list(i).class)
                    ret{j} = evalin('base', list(i).name);
                    j = j + 1;
                end
            end
        end     
    end
    
end
*/
