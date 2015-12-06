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
    		argvnum = 0;
    		if nargin > 1
    			[argvstr, argvdata, argvnum] = argvSep(varargin);
    		end
    		if argvnum == 0
    			obj.set_inner(obj, argvnum);
    		else
	    		obj.set_inner(obj, argvnum, argvstr, argvdata);
	    	end
    	end
    end
end

