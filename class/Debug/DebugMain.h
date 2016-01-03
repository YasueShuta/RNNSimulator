#pragma once
class DebugMain
{
public:
	DebugMain();
	~DebugMain();

	static int Main();

	static int ConsoleTest();
	static int FindableTest();
	static int OITest();
	static int ConnectableTest();
	static int ConnectableNodeTest();
	static int FigureViewerTest();
	static int RecorderTest();

	static int GnuplotTest();
	static int EigenTest();
};

