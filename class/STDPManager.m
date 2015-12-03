classdef STDPManager
    properties (Constant)
        deltaT = 0.1;
    end
    
    methods (Static)
        function func(n)
            disp(num2str(n));
        end
        
        function SpikeRecord(RP, t, n)
            RP.SpikeRecord = RP.Readout > RP.th;
            RP.SpikeTimeRecord = updateLast2Spike(RP.SpikeRecord, RP.SpikeTimeRecord, t, n);
        end
        
        function Update(RP, t, n)
            RP.dM = dotM(RP.NetworkMatrix, RP.SpikeRecord, RP.SpikeTimeRecord, t, n);
            RP.NetworkMatrix = RP.NetworkMatrix + RP.dM;
        end
    end
    
end
