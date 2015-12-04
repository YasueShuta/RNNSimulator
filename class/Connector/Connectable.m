classdef Connectable < handle
	properties
		isConnectableObject = true;
		isConnectable = true;
	end
	
	methods (Abstract)
		length_in(obj);
        length_out(obj);
		outflow(obj);
		inflow(obj, flow);
    end
    
    methods (Static)
        function ret = check(obj)
            ret = ~isempty(findprop(obj, 'isConnectableObject'));
        end
    end
end	
