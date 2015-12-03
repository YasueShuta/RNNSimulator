classdef RNNSTDPManager < handle & STDPManager
    properties (Constant)
        deltaT = 0.1;
    end
    
    events
        TargetChange
    end
    
    methods (Static)
        function SpikeRecord(R)
            R.SpikeRecord = R.Readout > R.th;
        end
        
        function SpikeTimeRecord(R, t, n)
            R.SpikeTimeRecord = updateLast2Spike(R.SpikeRecord, R.SpikeTimeRecord, t, n);
        end
    end
    
    methods
        function obj = RNNSTDPManager(R, state)
            obj.target = R;
            obj.dM = zeros(R.n);
            obj.trigger = state;
        end
        
        function createListener(obj)
            obj.lh = addlistener(obj, obj.trigger,  @UpdatedCallback);
        end
        
        function Update(obj, t, n)
            obj.dM = dotM(obj.target.NetworkMatrix, obj.target.SpikeRecord, obj.target.SpikeTimeRecord, t, n);
            obj.target.NetworkMatrix = obj.target.NetworkMatrix + obj.dM;
        end
    end
end
