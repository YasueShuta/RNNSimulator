% test_FunctionGenerator
dt = 0.1;
nsims = 144;
simtime = 1:dt:nsims-dt;

%% basic functions
%
fc = FunctionGenerator.constant(0.6, simtime);
fs = FunctionGenerator.sin(1.0, 1/144 * 3, 0.5*pi, simtime);
fz = FunctionGenerator.zero(simtime);
%}

%% figure plot
%
figure;
plot(simtime, fc, 'color', 'blue');
hold on;
plot(simtime, fs, 'color', 'green');
plot(simtime, fz, 'color', 'yellow');
%}
