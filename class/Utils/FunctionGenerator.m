classdef FunctionGenerator
	properties (Constant)
	end
	
	methods (Static)
		function f = constant(value, simtime)
			f = value * ones(simtime);
		end
		
		function f = sin(amp, freq, phi, simtime)
			f = amp * sin(2*pi*freq*simtime + phi);
		end
		
		function f = zero(simtime)
			f = zeros(simtime);
		end
		
		
	end		



end