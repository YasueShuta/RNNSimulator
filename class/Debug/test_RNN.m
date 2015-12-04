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
%{
obj = RNN.init('n', 24)
output = SingleOutput()
con = Connector(obj, output)
dt = 0.1
con.transmit(dt)
output.update()
disp(['Output: ', num2str(output.Output)]);

for i = 1:10
    obj.update(dt);
    con.transmit(dt);
    output.update();
    disp(['Output: ', num2str(output.Output)]);
    input('');
end
%}