% test_FORCE.m
clear all;

dt = 0.1;
simtime = 0:dt:144-dt;
len = length(simtime);

%% FORCE Initialize Test
fi = FORCEInitializer('alpha', 0.2, 'ra', 0.001, 'tf', FORCEDefault.target(simtime))
force = FORCE();
force.reset(fi);
force


%% Make Feedback Loop
zt = zeros(len, 1);
wo_len = zeros(len, 1);

rnn = RNN.init('n', 256);
ro = RNNObserver.init(rnn);
recRNN = zeros(len, ro.cellNum);
fb = SingleFeedback();
co = Connector(rnn, fb);%, zeros(1, rnn.n));
cb = Connector(fb, rnn);

%% Apply FORCE
ft = FORCEDefault.target(simtime);
force = FORCE.init(co, ft)
force.set('alpha', 1.0)
force


%% Input Small Signal
fi = 0.2*FORCEDefault.target(simtime);
input = SingleInput(fi);
ci = Connector(input, rnn);


%% simulation
figure;
ti = 0;
for i = simtime
    ti = ti + 1;
    
    if mod(ti, 144/1) == 0
        subplot 211;
        plot(simtime, ft, 'color', 'green');
        hold on;
        plot(simtime, zt, 'color', 'red');
        hold off;
        
        subplot 212;
        plot(simtime, wo_len)
        
        pause(0.5);
    end
    input.update();
    ci.transmit(dt);
    
    rnn.update(dt);
    co.transmit(dt);
    
    fb.update();
    cb.transmit(dt);
    
    force.update(ti);
    
    zt(ti) = fb.Output;
    wo_len(ti) = sqrt(co.weight*co.weight');
    
    recRNN(ti, :) = ro.data();
end

subplot 311
plot(simtime, force.target, 'color', 'green');
hold on;
plot(simtime, fi, 'color', 'blue');
plot(simtime, zt, 'color', 'red');
subplot 312
plot(simtime, wo_len);
subplot 313
plot(simtime, recRNN(:, 1));
hold on;
for i = 2:ro.cellNum
    plot(simtime, recRNN(:,i));
end


figure;
subplot 311
bar(ci.weight, 'b');
subplot 312
bar(co.weight, 'r');
subplot 313
bar(cb.weight, 'y');

