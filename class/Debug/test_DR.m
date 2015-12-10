% test_DataRecorder
clear all
DataRecorderInitializer('observer', 1, 'flag', 'sample')
rm = RecordManager('dir', 'testFile\garbage\sample')

%% register RNN Observer
%
rnn = RNN('n', 24)
%}

%
dr = DataRecorder.init()
dr.set('name', 'innerRNN');
ro = RNNObserver.init(rnn, dr)
%}
%{
ro = RNNObserver.init(rnn)
dr = DataRecorder.init(ro, 'innerRNN')
%}

%% Input to RNN to Output
%
dt = 0.1
simtime = 0:dt:30-dt;
len = length(simtime);
record = zeros(len, 1);
recRNN = zeros(len, ro.cellNum);
fi = FunctionGenerator.sin(1, 1, simtime, 0);
input = SingleInput(fi)
output = SingleOutput()
ci = Connector(input, rnn)
co = Connector(rnn, output)
co.transmit(dt)
output.update()
disp(['Output: ', num2str(output.Output)]);
ro.print()
%}

%% Simulation
%

ti = 0;
for i = simtime
    ti = ti + 1;
    input.update();
    ci.transmit(dt);
    rnn.update(dt);
    co.transmit(dt);
    output.update();
    disp(['Output: ', num2str(output.Output)]);
    record(ti) = output.Output;
    ro.print()
    recRNN(ti,:) = ro.data();
end
figure;
subplot 211
plot(simtime, record);
hold on;
plot(simtime, fi, 'color', 'red')
subplot 212
plot(simtime, recRNN(:, 1));
hold on;
for i = 2:ro.cellNum
    plot(simtime, recRNN(:,i));
end

%}