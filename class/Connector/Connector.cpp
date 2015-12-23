/*
classdef Connector < handle
	properties
		weight;
		w0;
		
		in;
		out;
	end
	
	methods
		function obj = Connector(in, out, weight)
			% in, out: Connectable 
			if nargin < 2 || ~Connectable.check(in) || ~Connectable.check(out)
				error('Invalid Argument');
			elseif nargin >= 3 && ~isempty(weight)
				if size(weight, 1) ~= out.length_in() || size(weight, 2) ~= in.length_out()
					error('Invalid Argument(weight)');
				end
			else
				weight = 2.0 * (rand(out.length_in(), in.length_out()) - 0.5);
			end
			obj.in = in;
			obj.out = out;
			obj.w0 = weight;
			obj.resetWeight();
		end
		
		function resetWeight(obj)
			obj.weight = obj.w0;
		end
		
		function flow = transmit(obj, dt)
			flow = obj.weight * obj.in.outflow * dt;
			obj.out.inflow(flow);
		end
	end
end
*/