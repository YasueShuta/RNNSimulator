classdef SimulationProperties < handle
    %SimulationProperties
    %
    
    properties
        nRec2Out;
        nsecs;
        t;
        ti;
        dt;
        mode = 0;
        rnn_mode = 0;
        force_mode = 0;
        
        flag = 'uninitialize';
        
        simtime;
        simtime_len;
        simtime_test;
        
        
        rnn;         % RNNProperties
        force;       % FORCEProperties
        record;      % FORCERecorder
        viewer;      % FigureViewer
    end
    
    methods
        function SP = SimulationProperties(varargin)
            if nargin > 0 && strcmp(varargin{1}, '-c')
                switch varargin{2}
                    case 'skip'
                        SP = SimulationManager.set_inner(SP, varargin);
                        return;
                    otherwise
                end
            end
            SP = SimulationManager.defaultSimulationProperties();   
            SimulationManager.set_inner(SP, varargin);
        end
        
    end
    
end

