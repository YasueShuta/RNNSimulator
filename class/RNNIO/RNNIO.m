classdef RNNIO < ObjectIO
    %RNNIO Interface Class for Input to/Output from RNN
    %   Basic of RNNIO
    
    properties
        state;      % state: inter_Input=-2, Input=-1, Loop=0, Output=1, inter_Output=2
        Potential;
        Readout;
    end
    
    methods
        function obj = RNNIO(state, len)
            obj.state = state;
            obj.Potential = zeros(len, 1);
            obj.Readout = zeros(len, 1);
        end
        
        function len = length_in(obj)
            len = length(obj.Readout);
        end
        function len = length_out(obj)
            len = length(obj.Potential);
        end
        
        function inflow(obj, flow)
            obj.Potential = obj.Potential + flow;
        end
        function flow = outflow(obj)
            flow = obj.Readout;
        end
        
        function update(obj)
            obj.readout();
        end
        
        function readout(obj)
            obj.Readout = obj.Potential;
        end
    end
end

