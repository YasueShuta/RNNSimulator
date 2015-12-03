function [ value ] = f_STDP( deltaT  )
%f_STDP spike timing に応じた結合更新の強さF(delta_t)を求める.
%   詳細説明をここに記述
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

