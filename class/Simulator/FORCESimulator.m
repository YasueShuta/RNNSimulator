classdef FORCESimulator < Simulator
    properties
        rnn;
        rnnOS;
        recZ;
        recRNN;
        force;
    end
    
    methods (Static)
        function main()
            obj = FORCESimulator();
            
            obj.initialize();
            
            obj.nTimeLoop();
            
            obj.testLoop();
            
            obj.finalize();
        end
    end
    
    methods
        function setSimulator(obj)
            disp('Set Simulator');
            obj.rnn = RNN.init(128);
            obj.rnnOS = RNNObserverSet.init(obj.rnn, 'innerRNN');
            obj.recZ = zeros(obj.simtime_len, 1);
            obj.recRNN = zeros(obj.simtime_len, obj.rnnOS.observer.cellNum);
            obj.force = FORCEModule.init(obj.rnn, obj.simtime);
        end
        
        function initialize(obj)            
            disp('Initialize');
        end
        
        function finalize(obj)            
            disp('Finalize');
        end
        
        function before_loop(obj)            
            disp('Before Loop');
        end
        
        function after_loop(obj)            
            disp('After Loop');
            figure;
            subplot 211
            plot(obj.simtime, obj.force.target, 'color', 'green');
            hold on;
            plot(obj.simtime, obj.recZ, 'color', 'red');
            subplot 212
            plot(obj.simtime, obj.recRNN(:, 1));
            hold on;
            for i = 2:obj.rnnOS.observer.cellNum
                plot(obj.simtime, obj.recRNN(:, i));
            end
        end
        
        function backto_loop(obj)            
            disp('Back to Loop');
        end
        
        function loop_once(obj)            
%            disp('Loop Once');
            obj.rnn.update(obj.dt);
            obj.force.cn_out.transmit(obj.dt);
            obj.force.cell.update();
            obj.force.cn_back.transmit(obj.dt);
            obj.force.force.update(obj.ti);
            
            obj.recZ(obj.ti) = obj.force.cell.Output;
            obj.rnnOS.observer.print();
            obj.recRNN(obj.ti, :) = obj.rnnOS.observer.data();
        end
        
        function loop_once_test(obj)            
%            disp('Loop Once Test');
        end            
    end
end