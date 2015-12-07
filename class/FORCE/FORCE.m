classdef FORCE < handle & FORCEInitializer & FORCEProperties & FORCEFunction
    %FORCE: FORCE Object related to Connector
    properties
        error;
        P;
        dw;    
        
        target;
        connector;
        isConnect=false;
    end
    
    methods
        function obj = FORCE(varargin)
            if nargin == 0
                obj.setDefault();
                return;
            end
            obj.set(varargin);
        end
        
        function reset(obj, FI)
            if nargin == 2 && obj ~= FI 
                FORCEInitializer.copy(obj, FI);
            end
            if ~isempty(obj.connector) && ~isempty(obj.connector.in)
                obj.isConnect = true;
                if ~isempty(obj.r_alpha)
                    obj.alpha = obj.col * obj.r_alpha;
                end
                obj.error = zeros(obj.row, 1);
                obj.P = (1.0/obj.alpha)*eye(obj.col);
                obj.dw = zeros(obj.row, obj.col);
            end
        end
        
        function set_inner(obj, argvnum, argvstr, argvdata)
            if nargin == 2 || argvnum == 0
                obj.set_inner@FORCEInitializer(0);
            else
                obj.set_inner@FORCEInitializer(argvnum, argvstr, argvdata);
            end
            for i = 1:argvnum
                switch argvstr{i}
                   case {'target', 't', 'tf'}
                       obj.target = argvdata{i};
                   case {'connector', 'con', 'c'}
                       obj.connector = argvdata{i};
                   otherwise
                end
            end
            obj.reset();
        end
            
                
    end
    
    methods (Static)
        function obj = init(connector, target)
            if nargin < 1
                obj = FORCE();
            elseif nargin < 2
                obj = FORCE('c', connector);
            else
                obj = FORCE('c', connector, 't', target);
            end
        end
    end    
end