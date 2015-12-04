% test_RNN.m
clear;
clear classes;

%%% RNN Initialize
%{
obj = RNN()
n = 5; p = 0.5; g = 1.0, th = 0.8;
obj = RNN(n)
obj = RNN(n, p, g)
obj = RNN(n, p, g, th)
M = ones(n, n); M_ = ones(n, 1);
x = ones(n, 1); x_ = ones(n, n);
obj = RNN(n, p, g, th, M)
obj = RNN(n, p, g, th, [], x)
obj = RNN(n, p, g, th, M, x)

ri = RNNInitializer()
ri = RNNInitializer({'n', n})
ri = RNNInitializer({'n', n, 'th', th, 'isPlastic', true})

obj = RNN;
obj.reset(ri)
%}

%%% Output from RNN

obj = RNN.init('n', 24)
dt = 0.1
simtime = 0:dt:10-dt;
len = length(simtime);
record = zeros(len, 1);
fi = sin(2*pi*simtime)
input = SingleInput(fi)
output = SingleOutput()
ci = Connector(input, obj)
co = Connector(obj, output)
co.transmit(dt)
output.update()
disp(['Output: ', num2str(output.Output)]);
ti = 0;
for i = simtime
    ti = ti + 1;
    input.update();
    ci.transmit(dt);
    obj.update(dt);
    co.transmit(dt);
    output.update();
    disp(['Output: ', num2str(output.Output)]);
    record(ti) = output.Output;
end
figure;
plot(simtime, record);
