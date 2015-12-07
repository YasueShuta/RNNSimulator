classdef RNN < handle & RNNInitializer & RNNFinalizer & RNNFunction & RNNConnectable 
	% RNN: Handle object for
	%      Recurrent Neural Network.
	properties
		Scale;				% scale: 1/sqrt(n*p)
		NetworkMatrix;		% M: Connection between neurons.
        Input;              % input:
		Potential;			% x: electrical potential of neurons.
		Readout;			% r: tanh x
        
        STDP;
    end
        
    methods
        function obj = RNN(varargin)
            if nargin == 0
                return;
            end
            
    		obj = RNN();
            obj.setDefault();
    		obj.set(varargin);
    		obj.setMode();
    		obj.reset();
        end
        
        function reset(obj, RI)
            % obj = RNN, RI = RNNInitializer
            if nargin < 2
                RI = obj;
            elseif obj ~= RI
                RNNInitializer.copy(obj, RI);
            end
            obj.Scale = 1/sqrt(RI.n*RI.p);
            obj.Input = zeros(RI.n, 1);
            obj.NetworkMatrix = RI.M0;
            obj.Potential = RI.x0;
            obj.readout();
        end        
        
        function setPlastic(obj)
        	if obj.isPlastic == false
        		obj.isPlastic = true;
        	end
        end
        
        function resetPlastic(obj)
        	if obj.isPlastic == true
        		obj.isPlastic = false;
        	end
        end
        
        function readout(obj)
            obj.Readout = tanh(obj.Potential);
        end
    end
end
        
