% test_RNN.m
clear;
clear classes;

%% RNN Initialize
%{
obj = RNN()
n = 5; p = 0.5; g = 1.0, th = 0.8;
obj = RNN.init(n)
obj = RNN.init(n, p, g)
obj = RNN.init(n, p, g, th)
M = ones(n, n); M_ = ones(n, 1);
x = ones(n, 1); x_ = ones(n, n);
obj = RNN.init(n, p, g, th, M)
obj = RNN.init(n, p, g, th, [], x)
obj = RNN.init(n, p, g, th, M, x)

ri = RNNInitializer()
ri = RNNInitializer('n', n)
ri = RNNInitializer('n', n, 'th', th, 'isPlastic', true)

obj = RNN;
obj.reset(ri)
%}

%% Output from RNN and RNNObserver

rnn = RNN('n', 24)
ro = RNNObserver.init(rnn)
dt = 0.1
simtime = 0:dt:30-dt;
len = length(simtime);
record = zeros(len, 1);
recRNN = zeros(len, ro.cellNum);
fi = sin(0.2*pi*simtime)
input = SingleInput(fi)
output = SingleOutput()
ci = Connector(input, rnn)
co = Connector(rnn, output)
co.transmit(dt)
output.update()
disp(['Output: ', num2str(output.Output)]);

%% Simulation
%{
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