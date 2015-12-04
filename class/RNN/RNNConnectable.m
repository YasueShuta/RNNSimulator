classdef RNNConnectable < Connectable & RNNProperties
	methods
        function len = length(obj)
            len = length(obj.Potential);
        end
        
        function flow = outflow(obj)
            flow = obj.Readout;
        end
        
        function inflow(obj, flow)
            obj.Potential = obj.Potential + flow;
        end
	end
end
