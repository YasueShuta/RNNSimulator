classdef FORCEInitializer < ObjectInitializer
   properties
       alpha;
       r_alpha=[];
       learn_every;
       
       mode=0;
       target_mode=0;
       
       flag='';
   end
   
   methods
       function obj = FORCEInitializer(varargin)
           obj.setDefault();
           if nargin == 0
               return;
           end
           obj.set(varargin);
       end
   
       function setDefault(obj)
           obj.alpha = FORCEDefault.alpha;
           obj.learn_every = FORCEDefault.learn_every;
       end
       
       function setMode(obj)
       end
       
       function set_inner(obj, argvnum, argvstr, argvdata)
           for i = 1:argvnum
               switch argvstr{i}
                   case {'alpha', 'a'}
                       obj.alpha = argvdata{i};
                   case {'r_alpha', 'ra'}
                       obj.r_alpha = argvdata{i};
                   case {'learn_every', 'le'}
                       obj.learn_every = argvdata{i};
                   case {'mode', 'm'}
                       obj.mode = argvdata{i};
                   case {'target_mode', 't_mode', 'tm'}
                       obj.target_mode = argvdata{i};
                   otherwise        
               end
           end
           obj.setMode();
       end
   end
   
   methods (Static)
       function copy(obj, src)
           obj.alpha = src.alpha;
           obj.r_alpha = src.r_alpha;
           obj.learn_every = src.learn_every;
       end
   end 
end