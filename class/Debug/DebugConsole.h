#pragma once

class DebugConsole
{
public:
	DebugConsole();
	~DebugConsole();

	// for cout, cin
	static void OpenConsole();
	static void CloseConsole();

	static void Wait();

	static bool isOpen;
	//	static FILE* fp_console;
};

