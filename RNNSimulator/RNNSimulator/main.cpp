#include "MyInclude.h"

int main(void) {
	DebugConsole::OpenConsole();

	std::cout << "Hello, World!" << std::endl;

	DebugConsole::Wait();
	DebugConsole::CloseConsole();
}