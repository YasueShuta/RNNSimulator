classdef FORCEModule < ObjectInitializer
   properties
       force;
       target;
       cell;
       cn_out;
       cn_back;
   end
   
   methods
       function obj = FORCEModule(varargin)
           obj.set(varargin);
       end
       
       function set_inner(obj, argvnum, argvstr, argvdata)
           FI = FORCEInitializer();
           if nargin < 2 || argvnum == 0
               FI.set_inner(0);
           else
               FI.set_inner(argvnum, argvstr, argvdata); % alpha, r_alpha, learn_every, target_mode
           end
           if isempty(obj.force)
               obj.force = FORCE();
           end
           obj.force.reset(FI);
       end
       
       function setDefault(obj)
       end
       
       function reset(obj, FI)
       end
   end
   
   methods (Static)
       function obj = init(rnn, simtime, target)
           obj = FORCEModule();
           obj.cell = SingleFeedback();
           obj.cn_out = Connector(rnn, obj.cell);
           obj.cn_back = Connector(obj.cell, rnn);
           if nargin < 3 || isempty(target)
               target = FORCEDefault.target(simtime);
           end
           obj.target = target;
           obj.force = FORCE.init(obj.cn_out, obj.target);
       end
   end
end