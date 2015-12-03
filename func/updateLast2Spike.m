function [last2Spike] = updateLast2Spike( spikeRecord, last2Spike , t, len)
%updateLast2Spike last2Spikeを更新する
%   時刻tにおけるスパイクspikeRecordに応じてスパイクタイムレコードlast2Spikeを更新する
    for i = 1:len
        if spikeRecord(i) == 1
            last2Spike(i,2) = t - last2Spike(i,1);
            last2Spike(i,1) = t;
        end
    end
end

