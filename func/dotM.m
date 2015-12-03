function [ Mdot ] = dotM( M, spikeRecord, last2Spike, t, len )
%dotM Mを更新するdM/dtを返す
%   シナプス結合Mの変化量
    ave = 0.32;
    scale = 1.0/ave;

    tau_pre = 0.028;
    tau_post = 0.088;
    
    max = 10 * ave;
    min = 0.1 * ave;

    Mdot = zeros(len, len);
    for j = 1:len
       if spikeRecord(j) == 1
            t_jj = last2Spike(j,2);
            for i = 1:len
                if M(j,i) < max && M(j,i) > -max
                    t_ii = last2Spike(i,2);
                    t_ij = t - last2Spike(i,1);
                    Mdot(j,i) = Mdot(j,i) + (1 - exp(- t_ii / tau_pre)) * ...
                        (1 - exp(- t_jj / tau_post)) * ...
                        f_STDP(t_ij);
                    Mdot(i,j) = Mdot(i,j) + (1 - exp(- t_jj / tau_pre)) * ...
                        (1 - exp(- t_ii / tau_post)) * ...
                        f_STDP(-t_ij);
                end
            end
       end
    end
    Mdot = Mdot * scale;
end

