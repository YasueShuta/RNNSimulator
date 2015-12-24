#pragma once
#include <string>

class DebugConsole
{
public:
	DebugConsole();
	~DebugConsole();

	// for cout, cin
	static void OpenConsole();
	static void CloseConsole();

	static void Wait();
	static std::string GetLine();

	static bool isOpen;
	//	static FILE* fp_console;
};

