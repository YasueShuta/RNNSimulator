classdef Connectable < handle
	properties
		isConnectableObject = true;
		isConnectable = true;
	end
	
	methods (Abstract)
		length(obj);
		outflow(obj);
		inflow(obj, flow);
	end
end	
