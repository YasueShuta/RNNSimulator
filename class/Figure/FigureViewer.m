classdef FigureViewer < ObjectInitializer
    %FigureViewer is a discription of parameters for MATLAB graph.
    %
    
    properties
        mode = 0;
        flag = 'initialize';
        
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
			obj.setMode();
		end
        
        function setMode(obj)
        end
        
        function register(obj, observer)
        	if nargin < 2
        		return;
        	else
        	obj.n_obs = obj.n_obs + 1;
        	obj.observers{obj.n_obs} = observer;
        end
        		
	end
	
	methods (Static)        
        function obj = init()
			obj = FigureViewer();
        end
    end
end
