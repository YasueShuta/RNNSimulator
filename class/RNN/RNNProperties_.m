classdef RNNProperties_ < handle
    %RNNProperties Record of RNN Properties in Simulation
    %   
    
    properties
        n;     % number of neurons.
        p;     % percentage of connecting.
        g;     % g greater than 1 leads to chaotic networks.
        th;

        mode;  % Network Initialization Mode (0: Random Sparse)
        isPlastic = false;
        isLoadedNetwork = false;
        load_name;
        
        flag;
        option;
    end
    
    properties
       Scale;
    end
    
    properties
        NetworkMatrix;
        Potential;
        Readout;
        SpikeRecord;
        SpikeTimeRecord;
        lh;
        dM;
        
        x0;
    end    
    
    events
        stateUpdated;
    end
    
    methods
        function RP = RNNProperties(varargin)
            if nargin > 0 && strcmp(varargin{1}, '-c')
                switch varargin{2}
                    case 'skip'
                        RP = RNNManager.set_inner(RP, varargin(3:length(varargin)));
                        RNNManager.setMode(RP);
                        return;
                    otherwise
                end
            end
            RP = RNNManager.defaultRNNProperties();
            RNNManager.set_inner(RP, varargin);
            RNNManager.setMode(RP);
        end
        
        
        function lh = createListener_inner(RP)
            lh = addlistener(RP, 'stateUpdated', @RP.UpdatedCallback);
        end

        
        function obj = UpdatedCallback(obj, eventSrc, eventData)
            if obj.isPlastic
                STDPManager.SpikeRecord(eventSrc, eventData.t, eventData.n);
                if mod(eventData.t, STDPManager.deltaT) == 0
                    STDPManager.Update(eventSrc, eventData.t, eventData.n);
                end
            end
        end
    end
    
end

