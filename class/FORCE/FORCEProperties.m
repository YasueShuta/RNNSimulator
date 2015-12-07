classdef FORCEProperties < handle
   % FORCEPROPERTIES: definition of FORCE Properties
   
   properties (Abstract)
       alpha;
       r_alpha;
       learn_every;
       
       mode;
       target_mode;
       
       target;
       connector;
       isConnect;
       
       error;
       P;
       dw;
       
       flag;
   end
   
   methods
       function n = n(obj)
           if ~obj.isConnect
               n = [];
           else
               n = obj.connector.in.length_in;
           end
       end
   end
end