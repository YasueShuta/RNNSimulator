#include "Gnuplot.h"

using namespace Gnuplot;

Handle::Handle()
{
	fp = _popen(GNUPLOT_EXE, "w");
}


Handle::~Handle()
{
	_pclose(fp);
}

void Handle::write()
{
	buf << std::endl;
	send();
}
void Handle::write(std::string s)
{
	buf << s << std::endl;
	send();
}
void Handle::write(const char* s)
{
	buf << s << std::endl;
	send();
}

void Handle::send()
{
	fputs(buf.str().c_str(), fp);
	fflush(fp);
}

void Handle::dispBuf()
{
	std::cout << buf.str() << std::endl;
}
