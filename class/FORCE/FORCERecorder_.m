classdef FORCERecorder < handle
    %FORCERecoreder records FORCE Properties for Display
    
    properties
        wo_len;
        dM_tr;
        M_tr;
        M_tr0;
        zt;
        zpt;
        errt;
        ave_err;
        
        x0;
        z0;
    end
    
    methods
        function obj = FORCERecorder(simtime, x0, z0)
            obj.wo_len = zeros(size(simtime));
            obj.dM_tr = zeros(size(simtime));
            obj.M_tr = zeros(size(simtime));
            obj.zt = zeros(size(simtime));
            obj.zpt = zeros(size(simtime));
            obj.errt = zeros(size(simtime));
            
            obj.x0 = x0;
            obj.z0 = z0;
        end
        
        function store(FR, ti, RP, FP)
            FR.zt(ti) = FP.Output;
            FR.wo_len(ti) = sqrt(FP.wo'*FP.wo);
%            if mod(ti, 100) == 0
%                FR.dM_tr(ti) = sqrt(trace(RP.dM' * RP.dM)/RP.n);
%            end
            if isempty(FR.M_tr0)
                FR.M_tr0 = sqrt(trace(RP.NetworkMatrix' * RP.NetworkMatrix)/RP.n);
            elseif mod(ti, 100) == 1
                FR.M_tr(ti) = sqrt(trace(RP.NetworkMatrix' * RP.NetworkMatrix)/RP.n)-FR.M_tr0;
            else
                FR.M_tr(ti) = FR.M_tr(ti-1);
            end
            FR.errt(ti) = FP.e;
        end
        
        function ret = calcAveErr(FR, SP)
            FR.ave_err = sum(abs(FR.errt))/SP.simtime_len;
            ret = FR.ave_err;
        end
    end
end