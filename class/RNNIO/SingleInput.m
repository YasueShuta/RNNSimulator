classdef SingleInput < RNNIO
   %SINGLEINPUT
   %
   properties
       Input;
       ti;
       ti_max;
   end
   methods
       function obj = SingleInput(fi)
           obj@RNNIO(-1, 1);
           obj.Input = fi;
           obj.ti = 0;
           obj.ti_max = length(fi);
       end
       
       function len = length_in(obj)
           len = [];
       end
       
       function inflow(obj, flow)
           return;
       end
       
       function readout(obj)
           obj.ti = obj.ti + 1;
           if obj.ti > obj.ti_max
               obj.ti = 1;
           end
           obj.Readout = obj.Input(obj.ti);
       end
   end
end