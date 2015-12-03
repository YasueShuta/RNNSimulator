function [ p, g, r_alpha, dt, learn_every ] = param_network( pin, gin, r_alphain, dtin, learn_everyin)
dp = 0.1;
dg = 1.5;
dr_alpha = 0.001;
ddt = 0.1;
dlearn_every = 2;    

if nargin < 5 || learn_everyin == 0
    learn_everyin = dlearn_every;
end
if nargin < 4 || dtin == 0
    dtin = ddt;
end
if nargin < 3 || r_alphain == 0
    r_alphain = dr_alpha;
end
if nargin < 2 || gin == 0
    gin = dg;
end
if nargin < 1 || pin == 0
    pin = dp;
end

 p = pin;
 g = gin;
 r_alpha = r_alphain;
 dt = dtin;
 learn_every = learn_everyin;
end