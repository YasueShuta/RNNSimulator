classdef RNNConnectable < Connectable & RNNProperties
       methods
        function len = length_in(obj)
            len = length(obj.Readout);
        end
        
        function len = length_out(obj)
            len = length(obj.Input);
        end
        
        function flow = outflow(obj)
            flow = obj.Readout;
        end
        
        function inflow(obj, flow)
            obj.Input = flow;
        end
	end
end
