function [ p ] = mypath()
   folderName = 'C:\Users\mech-user\Documents\MATLAB\RNNSimulator';
   p = genpath(folderName);
   addpath(p);
end
