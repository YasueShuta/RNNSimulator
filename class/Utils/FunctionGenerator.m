classdef FunctionGenerator
	properties (Constant)
	end
	
	methods (Static)
		function f = constant(value, simtime)
			f = value * ones(1, length(simtime));
		end
		
		function f = sin(amp, freq, phi, simtime)
			f = amp * sin(2*pi*freq*simtime + phi);
		end
		
		function f = zero(simtime)
			f = zeros(1, length(simtime));
		end
		
		
	end		



end