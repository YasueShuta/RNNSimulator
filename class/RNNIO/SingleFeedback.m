classdef SingleFeedback < RNNIO
    %SINGLEFEEDBACK: RNN -> SingleFeedback -> RNN
    %
    properties
        Output;
    end
    
    methods
        function obj = SingleFeedback()
            obj@RNNIO(0, 1);
        end
        
        function inflow(obj, flow)
            obj.Potential = flow;
        end
        
        function readout(obj)
            obj.readout@RNNIO();
            obj.Output = obj.Readout;
        end
    end
end
