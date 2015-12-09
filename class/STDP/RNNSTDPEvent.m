classdef RNNSTDPEvent < RNNProperties & STDPEvent
    properties (Constant)
        deltaT = 0.1;
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
        function obj = RNNSTDPEvent(R, state)
            obj.target = R;
            obj.dM = zeros(R.n);
            obj.trigger = state;
        end
        
        function UpdateTarget(obj, t, n)
            obj.dM = dotM(obj.target.NetworkMatrix, obj.target.SpikeRecord, obj.target.SpikeTimeRecord, t, n);
            obj.target.NetworkMatrix = obj.target.NetworkMatrix + obj.dM;
        end
    end
end
