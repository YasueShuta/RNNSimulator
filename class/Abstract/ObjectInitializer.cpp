/*
classdef ObjectInitializer < MyObject
    %OBJECTINITIALIZER Interface for Initializer.
    %   Allocation rules, set parameter interface, e.t.c.
    
    properties
    end
    
    methods (Abstract)
        set_inner(obj, argvnum, argvstr, argvdata);
    end
    methods
    	function set(obj, varargin)
    		if nargin < 2
                obj.set_inner(0);
                return;
            elseif iscell(varargin{1})
                if isempty(varargin{1})
                    obj.set_inner(0);
                    return;
                end
    			[argvstr, argvdata, argvnum] = argvSep(varargin{1});
            else
                [argvstr, argvdata, argvnum] = argvSep(varargin);
            end
            obj.set_inner(argvnum, argvstr, argvdata);
    	end
    end
end

*/