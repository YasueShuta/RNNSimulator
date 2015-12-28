#pragma once

namespace RNNSimulator {
	template <typename T>
	T Observer::data() {
		T* ptr = (T*)dataptr;
		return *ptr;
	}
}
