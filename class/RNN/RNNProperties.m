classdef RNNProperties < handle
    %RNNProperties: Abstract Properties for RNN Classes
    %   
    properties (Abstract)
        NetworkMatrix;
        Potential;
        Readout;
        STDP;
    end    
end
