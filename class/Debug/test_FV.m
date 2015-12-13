% test_RNN.m
clear;
clear all;

%% Initialization
%{
r1 = RNNObserver(); r2 = RNNObserver; r3 = RNNObserver;
fv = FigureViewer()
fv.register(r2)
fv.register(r1)
fv.register(r2)
fv.register(r3)
%}

%% Output from RNN and RNNObserver

rnn = RNN.init(1024)
fv = FigureViewer()
ro = RNNObserver.init(rnn, [], fv)
dt = 0.1
simtime = 0:dt:1440-dt;
len = length(simtime);
ro.initFigureData(simtime);
ro.plot(simtime);
%fi = sin(0.2*pi*simtime);
%input = SingleInput(fi)
%ci = Connector(input, rnn)

force = FORCEModule.init(rnn, simtime);
fo = FORCEObserver.init(force)
fo.initFigureData(simtime);
fo.plot(simtime);

%% Simulation
%
ti = 0;
for i = simtime
    ti = ti + 1;
%    input.update();
%    ci.transmit(dt);
    rnn.update(dt);
    force.update(dt, ti);

    ro.recordFigureData(ti);
    ro.plot(simtime, ti)
    ro.print()

    fo.recordFigureData(ti);
    fo.plot(simtime, ti)
    fo.print()
end
%}