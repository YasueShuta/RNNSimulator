function [last2Spike] = updateLast2Spike( spikeRecord, last2Spike , t, len)
%updateLast2Spike last2Spike���X�V����
%   ����t�ɂ�����X�p�C�NspikeRecord�ɉ����ăX�p�C�N�^�C�����R�[�hlast2Spike���X�V����
    for i = 1:len
        if spikeRecord(i) == 1
            last2Spike(i,2) = t - last2Spike(i,1);
            last2Spike(i,1) = t;
        end
    end
end

