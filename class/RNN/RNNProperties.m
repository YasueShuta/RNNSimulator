classdef RNNProperties < handle
    %RNNProperties: Abstract Properties for RNN Classes
    %   
    properties (Abstract)
        NetworkMatrix;
        Input;
        Potential;
        Readout;
        STDP;
    end    
end
