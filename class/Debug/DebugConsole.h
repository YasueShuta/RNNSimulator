#pragma once
#include <string>
#include <conio.h>

class DebugConsole
{
public:
	DebugConsole();
	~DebugConsole();

	// for cout, cin
	static void OpenConsole();
	static void CloseConsole();

	static void Wait();
	static bool WaitKey(char c_);
	static std::string GetLine();

	static bool isOpen;
	//	static FILE* fp_console;
};

