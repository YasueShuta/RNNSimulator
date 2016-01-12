// Including
//#include "MyInclude.h"
//#include "../../class/Debug/DebugMain.h"
#include "../../class/Debug/DebugConsole.h"
#include "../../class/Abstract/Findable.h"
#include "../../class/Abstract/ObjectInitializer.h"
#include "../../class/Connector/Connectable.h"
#include "../../class/Connector/Connector.h"
#include "../../class/Connector/ConnectableNode.h"
#include "../../class/Figure/FigureViewer.h"
#include "../../class/Recorder/IdManager.h"
#include "../../class/Recorder/DataRecorder.h"
#include "../../class/RNN/RNNNode.h"
#include "../../class/Observer/Observer.h"
#include "../../class/Observer/TemporalObserver.h"
#include "../../class/FORCE/RLSModule.h"
#include "../../class/FORCE/FORCEModule.h"

#include "../../class/gnuplotInterface/Gnuplot.h"

using namespace RNNSimulator;
using namespace Gnuplot;
using namespace Eigen;

int main(void) {
	GP* fig1 = new GP(true,  // -persist
		"windows",           // terminal
		"FORCE: 1",             // window title
		"Times New Roman",   // font
		18,                  // font size
		640, 330,            // window size
		700, 30);            // window position
	GP* fig2 = new GP(true,  // -persist
		"windows",           // terminal
		"FORCE: 2",             // window title
		"Times New Roman",   // font
		18,                  // font size
		640, 330,            // window size
		30, 400);            // window position
	GP* fig3= new GP(true,  // -persist
		"windows",           // terminal
		"FORCE: 3",             // window title
		"Times New Roman",   // font
		18,                  // font size
		640, 330,            // window size
		700, 400);           // window position

	DebugConsole::OpenConsole();

	SimTime* time = SimTime::getObject(1000, 0.05);//(nsecs, dt)

	/*[Option]Default value:
	[-n]64
	[-p]0.1
	[-g]1.5
	*/
	RNNNode* rnn = new RNNNode("-n 256 -p 0.1");
	/*[Option]Default value: if change call set(varargnum, ...)
	[-a]r_alpha * cellNum
	[-r]0.001
	*/
	FORCEModule* force = new FORCEModule(rnn);
	force->wo->target_mode = 2;
	force->wo->tf.gain = 2.3;
	force->wo->tf.freq = 0.002;

	int xlen = round(200/time->dt);
	std::vector<double> xvec(xlen);
	for (int i = 0;i < xlen;i++) {
		xvec.at(i) = i*time->dt;
	}
	int plot_every = round(xlen / 3);

	std::vector<double> fr_error = std::vector<double>(xlen, 0);
	std::vector<double> fr_target = std::vector<double>(xlen, 0);
	std::vector<double> fr_output = std::vector<double>(xlen, 0);
	std::vector<double> fr_normwo = std::vector<double>(xlen, 0);
	std::vector<double> fr_normP = std::vector<double>(xlen, 0);
	std::vector<double> rnn_R0 = std::vector<double>(xlen, 0);

	std::cout << "|network| " << rnn->network.norm() << std::endl;
	std::cout << "|wf| " << force->wf->weight.norm() << std::endl;

	while(time->ok()) {
		if (time->ti > 0.5*time->len) {
			//force->wo->target_mode = 0;
		}
		{
			//Main Loop
			rnn->update();
			force->update();
//			std::cout << force->node->potential << "|" << force->wf->input << std::endl;
		}

		{
			//Record
			fr_error.at(time->ti%xlen) = force->wo->error(0);
			fr_target.at(time->ti%xlen) = force->wo->target_value(0);
			fr_output.at(time->ti%xlen) = force->node->readout(0);
			fr_normwo.at(time->ti%xlen) = force->wo->weight.norm();
			fr_normP.at(time->ti%xlen) = rnn->potential.norm();
			rnn_R0.at(time->ti%xlen) = rnn->input.norm();

			//Draw
			if (time->ti % plot_every == 0 || time->ti == time->len-1) {
				fig1->plotVec2Multi(xvec,
     				{ fr_output, fr_target},
					3,
					{ "red", "green" },
					{ "output", "target" });
				fig2->plotVec2(xvec,
					fr_normwo,
					"|w|",
					3,
					"blue");
//				fig3->plotVec2(xvec,rnn_R0,"readout0",3,"blue");
				fig3->plotVec2Multi(xvec, { rnn_R0, fr_normP }, 3, { "red", "blue" }, { "R0", "|P|" });
			}
		}
		time->step();
	}

	return 0;
};