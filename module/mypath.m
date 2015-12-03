function [ p ] = mypath()
   folderName = 'C:\Users\mech-user\Documents\MATLAB\sim';
   p = genpath(folderName);
   addpath(p);
end
