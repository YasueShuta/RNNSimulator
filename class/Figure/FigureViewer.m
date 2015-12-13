classdef FigureViewer < ObjectInitializer & FigureFunction
    %FigureViewer is a discription of parameters for MATLAB graph.
    %
    
    properties
        mode = 0;
        flag = 'initialize';
        id;
        
        figure_id;
        n_sub;
        
        linewidth;
        fontsize;
        fontweight;
        
        layout_x;
		layout_y;
		layout_i;
	    
	    observers={};
	  	n_obs=0;
	  	
        manager;
    end
    
    methods
        function obj = FigureViewer(varargin)
			obj.set(varargin);
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			obj.setDefault();
			if nargin < 2 || argvnum == 0
			else
				for i = 1:argvnum
                	switch argvstr{i}
                	   	case {'mode'}
                        	obj.mode = argvdata{i};
                        case {'flag'}
                            obj.flag = argvdata{i};
                        otherwise
                    end
                end
            end
            obj.reset();
        end

		function reset(obj)
			if isempty(obj.manager)
				obj.manager = FigureManager.getObject();
				obj.linewidth = obj.manager.linewidth;
				obj.fontsize = obj.manager.fontsize;
				obj.fontweight = obj.manager.fontweight;
			end
			if isempty(obj.figure_id)
				obj.figure_id = figure;
            end
            if isempty(obj.id)
                obj.setId();
            end
			obj.setMode();
		end
        
        function setMode(obj)
        end
        
        function setDefault(obj)
        end
        
        function setId(obj)
            if ~isempty(obj.id)
                return;
            end
            obj.id = FigureManager.getId(obj);
        end
        function register(obj, observer)
        	if nargin < 2 || ~isa(observer, 'Observer')
        		return;
            end
            for i = 1:obj.n_obs
                if observer == obj.observers{i}
                    return;
                end
            end
            obj.n_obs = obj.n_obs + 1;
            obj.observers{obj.n_obs} = observer;
            if isempty(observer.viewer);
                observer.registerViewer(obj);
            end
        end	
	end
	
	methods (Static)        
        function obj = init(observer)
            if nargin < 1 || isempty(observer)
    			obj = FigureViewer();
                return;
            end
            obj = FigureViewer();
            obj.register(observer);
        end
    end
end
