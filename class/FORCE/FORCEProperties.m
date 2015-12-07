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
       function col = col(obj)
           if ~obj.isConnect
               col = [];
           else
               col = obj.connector.in.length_in;
           end
       end
       
       function row = row(obj)
           if ~obj.isConnect
               row = [];
           else
               row = obj.connector.out.length_out;
           end
       end
   end
end