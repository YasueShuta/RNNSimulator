#pragma once

namespace RNNSimulator {
	template <typename T> void* findObject(){
		return findObject<T>(-1);
	}

	template <typename T> void* findObject(int id_) {
		if (id_ == Findable::NEXTID) return Findable::ROOT;
		Findable* curr = T::ROOT;
		for (int i = 0;i < T::NEXTID; i++) {
			/*
			std::cout << "Curr: " << typeid(*curr).name() << std::endl;
			std::cout << "Find: " << typeid(T).name() << std::endl;
			*/
			if (typeid(T) == typeid(Findable) || typeid(*curr) == typeid(T))
				if (id_ < 0 || curr->id == id_)
					return curr;
			curr = curr->next;
		}
		return NULL;
	}
}