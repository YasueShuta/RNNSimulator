#include "DebugConsole.h"
#include <iostream>
#include <string>
#include <windows.h>

bool DebugConsole::isOpen = false;

DebugConsole::DebugConsole()
{
}


DebugConsole::~DebugConsole()
{
}

void DebugConsole::OpenConsole()
{
	FILE* fp;
	::AllocConsole();
	// apply stdout
	freopen_s(&fp, "CON", "w", stdout);
	freopen_s(&fp, "CON", "r", stdin);

	DebugConsole::isOpen = true;
}

void DebugConsole::CloseConsole()
{
	::FreeConsole();
	DebugConsole::isOpen = false;
}

void DebugConsole::Wait()
{
	std::cout << "(If Stop, Press Enter: )" << std::endl;
	std::cin.clear();
	std::cin.ignore();
	std::cout << "Press Enter:";
	std::cin.get();
}

std::string DebugConsole::GetLine()
{
	std::string ret;
	std::cout << "$ ";
	std::getline(std::cin, ret);
	return ret;
}