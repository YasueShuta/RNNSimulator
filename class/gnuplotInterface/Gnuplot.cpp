#include "Gnuplot.h"

using namespace Gnuplot;

#ifndef _GNUPLOT_CPP
#define _GNUPLOT_CPP
int Handle::NEXTID = 0;
Handle* Handle::HEAD = NULL;
#endif

Handle::Handle(const char* options_) {
	std::stringstream ss;
	ss << GNUPLOT_EXE;
	if (std::strlen(options_)) {
		ss << " " << options_;
	}
	fp = _popen(ss.str().c_str(), "w");
	setId();
}
void Handle::setId() {
	id = NEXTID;
	NEXTID += 1;

	nextHandle = HEAD;
	HEAD = this;
}
Handle::~Handle()
{
	Handle* curr = HEAD;
	if (curr == this) {
		HEAD = this->nextHandle;
	}
	while (curr->nextHandle != NULL) {
		if (curr->nextHandle == this) {
			curr->nextHandle = this->nextHandle;
			break;
		}
		curr = curr->nextHandle;
	}
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
	resetBuf();
}

void Handle::dispBuf()
{
	std::cout << buf.str() << std::endl;
}

void Handle::resetBuf()
{
	buf.str("");
}

Handle* Handle::findHandle(int id_) {
	Handle* curr = HEAD;
	while (curr != NULL) {
		if (curr->id == id_) break;
		curr = curr->nextHandle;
	}
	return curr;
}

GP::GP()
{
	h = new Handle();
}
GP::GP(const char* option_) {
	h = new Handle(option_);
}
GP::GP(int id) {
	h = Handle::findHandle(id);
}
GP::GP(Handle* h_) {
	h = h_;
}
GP::GP(bool isPOption_, const char* terminal_, const char* title_, int wsize_x_, int wsize_y_, int woffset_x, int woffset_y, const char* file_) {
	std::stringstream ss;
	if (isPOption_) {
		ss << " --persist";
	}
	h = new Handle(ss.str().c_str());

	ss.str("");

	ss << "set terminal " << terminal_;
	if (std::strlen(title_) > 0)
		ss << " title \"" << title_ << "\"";
	ss << " size " << wsize_x_ << "," << wsize_y_;
	ss << " position " << woffset_x << "," << woffset_y;

	std::cout << ss.str() << std::endl;

	h->write(ss.str());
}
GP::~GP()
{
};

void GP::plotVec2(std::vector<double> xdata_, std::vector<double> ydata_, const char* option_) {
	if (xdata_.size() != ydata_.size()) return;
	h->buf << "plot '-' " << option_;
	h->write();
	for (int i = 0;i < xdata_.size(); i++) {
		h->buf << xdata_.at(i) << " " << ydata_.at(i);
		h->write();
	}
	h->write("e");
}
void GP::plotVec2Multi(std::vector<double> xdata_, std::vector<std::vector<double>> ydataarray_, std::vector<const char*> optionarray_) {
	int len = xdata_.size();
	int ynum = ydataarray_.size();
	h->buf << "plot";
	for (int i = 0;i < ynum;i++) {
		h->buf << " '-'";
		if (optionarray_.size() > 0)
			h->buf << " " << optionarray_.at(i);
		if (i < ynum - 1) h->buf << ", ";
	}
	h->write();
	for (int i = 0;i < ynum; i++){
		for (int j = 0;j < len; j++) {
			h->buf << xdata_.at(j) << " " << ydataarray_.at(i).at(j);
			h->write();
		}
		h->write("e");
	}
}
void GP::plotVec2(double* xdata_, double* ydata_, int num, const char* option_) {
	h->buf << "plot '-' " << option_;
	h->write();
	for (int i = 0;i < num;i++) {
		h->buf << xdata_[i] << " " << ydata_[i];
		h->write();
	}
	h->write("e");
	h->write("replot");
}
void GP::plotVec2Multi(double* xdata_, int len_, double* ydataarray_[], int num_, const char* optionarray_[]) {
	h->buf << "plot";
	for (int i = 0;i < num_;i++) {
		h->buf << " '-'";
		if (optionarray_ != NULL)
			h->buf << " " << optionarray_[i];
		if (i < num_ - 1) h->buf << ", ";
	}
	h->write();
	for (int i = 0;i < num_;i++) {
		for (int j = 0;j < len_; j++) {
			h->buf << xdata_[j] << " " << ydataarray_[i][j];
			h->write();
		}
		h->write("e");
	}
}


void GP::replotAll() {
	Gnuplot::GP* tmp;
	for (int i = 0;i < Handle::NEXTID; i++) {
		tmp = new Gnuplot::GP(i);
		if (tmp != NULL) tmp->hwrite("replot");
	}
}