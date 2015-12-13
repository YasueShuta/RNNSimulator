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
    		obj.set(varargin);
        end
        
        function reset(obj)
            % obj = RNN, RI = RNNInitializer
            obj.reset@RNNInitializer();
            obj.Scale = 1/sqrt(obj.n*obj.p);
            obj.Input = zeros(obj.n, 1);
            obj.NetworkMatrix = obj.M0;
            obj.Potential = obj.x0;
            obj.readout();
        end        
        
        function readout(obj)
            obj.Readout = tanh(obj.Potential);
        end
    end
end
        
