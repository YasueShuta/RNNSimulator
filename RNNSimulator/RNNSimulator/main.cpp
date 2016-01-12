// Including
//#include "MyInclude.h"
//#include "../../class/Debug/DebugMain.h"
#include "../../class/Debug/DebugConsole.h"
//#include "../../class/Abstract/Findable.h"
//#include "../../class/Abstract/ObjectInitializer.h"
//#include "../../class/Connector/Connectable.h"
#include "../../class/Connector/Connector.h"
#include "../../class/Connector/ConnectableNode.h"
//#include "../../class/Figure/FigureViewer.h"
//#include "../../class/Recorder/IdManager.h"
//#include "../../class/Recorder/DataRecorder.h"
#include "../../class/RNN/RNNNode.h"
#include "../../class/Observer/Observer.h"
#include "../../class/Observer/TemporalObserver.h"
//#include "../../class/FORCE/RLSModule.h"
#include "../../class/FORCE/FORCEModule.h"
#include "../../class/RNN/InputNode.h"

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
	GP* fig3 = new GP(true,  // -persist
		"windows",           // terminal
		"FORCE: 3",             // window title
		"Times New Roman",   // font
		18,                  // font size
		640, 330,            // window size
		700, 400);           // window position

	fig1->hwrite("set xlabel 'time [s]'"); fig1->hwrite("set ylabel 'value'");
	fig2->hwrite("set xlabel 'time [s]'"); fig2->hwrite("set ylabel 'value'");
	fig3->hwrite("set xlabel 'time [s]'"); fig3->hwrite("set ylabel 'value'");
	fig1->hwrite("set xrange [0:100]");
	fig2->hwrite("set xrange [0:100]");
	fig3->hwrite("set xrange [0:100]");

	DebugConsole::OpenConsole();

	SimTime* time = SimTime::getObject(3000, 0.001);//(nsecs, dt)

	//RNN Initialize
	/*
	* [Option]Default value:
	* [-n]64
	* [-p]0.1
	* [-g]1.5
	*/
	RNNNode* rnn = new RNNNode("-n 256 -p 0.1");

	//FORCE Learning Initialize
	/*[Option]Default value: if change call set(varargnum, ...)
	[-a]r_alpha * cellNum
	[-r]0.001
	*/
	FORCEModule* force = new FORCEModule(rnn);
	force->wo->target_mode = 1;
	force->wo->tf.gain = 1.0;

	//Input Initialize
	InputNode* input = new InputNode(1, 1, 1.0);
	Connector* wi = new Connector(input, rnn, 2, 0, 1);

	std::vector<double> fr_error = std::vector<double>(time->len, 0);
	std::vector<double> fr_target = std::vector<double>(time->len, 0);
	std::vector<double> fr_output = std::vector<double>(time->len, 0);
	std::vector<double> fr_normwo = std::vector<double>(time->len, 0);
	std::vector<double> ir_out = std::vector<double>(time->len, 0);

	while (time->ok()) {
		{
			//Schedule
			if (0 == time->ti % (int)round(0.1*time->len)) {
				force->wo->target_mode = !force->wo->target_mode;
				input->input_mode = !input->input_mode;
			}
		}
		{
			//Main Loop
			input->update();
			wi->transmit(1);
			rnn->update();
			force->update();
			//			std::cout << force->node->potential << "|" << force->wf->input << std::endl;
		}

		{
			//Record
			fr_error.at(time->ti) = force->wo->error(0);
			fr_target.at(time->ti) = force->wo->target_value(0);
			fr_output.at(time->ti) = force->node->readout(0);
			fr_normwo.at(time->ti) = force->wo->weight.norm();
			ir_out.at(time->ti) = input->output(0);

			//Draw
			if (false){//time->ti % plot_every == 0 || time->ti == time->len - 1) {
				fig1->plotVec2Multi(time->data,
				{ fr_output, fr_target },
					3,
					{ "red", "green"},
					{ "output", "target"});
				fig2->plotVec2(time->data,
					fr_normwo,
					"|w|",
					3,
					"blue");
				fig3->plotVec2(time->data,ir_out,"input",3,"yellow");
				//fig3->plotVec2Multi(time->data, { ir_out, fr_normP }, 3, { "red", "blue" }, { "R0", "|P|" });
			}
		}
		time->step();
	}
	fig1->plotVec2Multi(time->data,
	{ fr_output, fr_target },
		3,
		{ "red", "green" },
		{ "output", "target" });
	fig2->plotVec2(time->data,
		fr_normwo,
		"|w|",
		3,
		"blue");
	fig3->plotVec2(time->data, ir_out, "input", 3, "yellow");
	
	{
		//Record
		std::ofstream ofs("record.txt");
		ofs << "time,output,target,input,error" << std::endl;
		for (int i = 0;i < time->len;i++) {
			ofs << time->data.at(i) << ",";
			ofs << fr_output.at(i) << ",";
			ofs << fr_target.at(i) << ",";
			ofs << ir_out.at(i) << ",";
			ofs << fr_error.at(i) << std::endl;
		}
	}
	std::cout << "Finish..." << std::endl;
	DebugConsole::CloseConsole();
	return 0;
}