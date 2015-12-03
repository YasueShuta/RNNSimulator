function [ lw, fs, fw ] = param_graph( linewidth, fontsize, fontweight )
dlw = 3;
dfs = 14;
dfw = 'bold';
if nargin < 3 || fontweight == ''
    fontweight = dfw;
end
    
if nargin < 2 || fontsize == 0
    fontsize = dfs;
end

if nargin < 1 || linewidth == 0
    linewidth = dlw;
end

lw = linewidth;
fs = fontsize;
fw = fontweight;
end

