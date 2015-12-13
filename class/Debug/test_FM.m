% test FORCE Module
clear all

rnn = RNN.init(1024);
dt = 0.1;
simtime = 1:dt:1440-dt;
force = FORCEModule.init(rnn, simtime)

force.cell.Output
rnn.update(dt)
force.cn_out.transmit(dt)
force.cell.update()
force.cn_back.transmit(dt)
force.cell.Output

ti = 0;
for i = simtime
    ti = ti + 1;
    rnn.update(dt);
    force.update(dt, ti);
    disp(['Output: ', num2str(force.cell.Output)]);
end