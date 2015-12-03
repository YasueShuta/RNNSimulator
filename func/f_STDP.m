function [ value ] = f_STDP( deltaT  )
%f_STDP spike timing �ɉ����������X�V�̋���F(delta_t)�����߂�.
%   �ڍא����������ɋL�q
A_plus = 0.032;
A_minus = -0.016;
tau_plus = 0.013;
tau_minus = 0.035;

value = 0;
if deltaT > 0
    value = A_plus * exp(-deltaT / tau_plus);
elseif deltaT < 0
    value = A_minus * exp(deltaT / tau_minus);
end

end

