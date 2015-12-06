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
        function obj = RNN(n, p, g, th, M0, x0)
            if nargin == 0
                return;
            end
            if nargin < 6
                x0 = [];
            end
            if nargin < 5
                M0 = [];
            end
            if nargin < 4
                th = [];
            end
            if nargin < 3
                g = [];
            end
            if nargin < 2 || isempty(p)
                p = [];
            end
            obj = obj.init6(n, p, g, th, M0, x0);
        end
    end
end
        
