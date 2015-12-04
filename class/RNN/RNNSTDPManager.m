classdef RNNSTDPManager < RNNProperties & STDPManager
    properties (Constant)
        deltaT = 0.1;
    end
    properties
        SpikeRecord;
        SpikeTimeRecord;
    end
    
    methods (Static)
        function recordSpike(R)
            R.SpikeRecord = R.Readout > R.th;
        end
        
        function recordSpikeTime(R, t, n)
            R.SpikeTimeRecord = updateLast2Spike(R.SpikeRecord, R.SpikeTimeRecord, t, n);
        end
        
        function updateTarget(obj, t, n)
            obj.dM = dotM(obj.target.NetworkMatrix, obj.target.SpikeRecord, obj.target.SpikeTimeRecord, t, n);
            obj.target.NetworkMatrix = obj.target.NetworkMatrix + obj.dM;
        end
    end
    
    methods
        function obj = RNNSTDPManager(R)
            obj.target = R;
            obj.dM = zeros(R.n);
            obj.SpikeRecord = zeros(R.n, 1);
            obj.SpikeTimeRecord = zeros(R.n, 2);
        end
    end
end
