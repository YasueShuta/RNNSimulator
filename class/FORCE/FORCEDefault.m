classdef FORCEDefault
   properties (Constant)
       alpha = 1.0;
       learn_every = 2;
   end
   
   methods (Static)
       function tf = target(simtime)        
           amp = 1.3;
           freq = 1/60;
           tf = (amp/1.0)*sin(1.0*pi*freq*simtime) + ...
               (amp/2.0)*sin(2.0*pi*freq*simtime) + ...
               (amp/6.0)*sin(3.0*pi*freq*simtime) + ...
               (amp/3.0)*sin(4.0*pi*freq*simtime);
           tf = tf/1.5;
       end
   end
end