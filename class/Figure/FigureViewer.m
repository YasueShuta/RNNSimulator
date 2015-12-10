classdef FigureViewer < ObjectInitializer
    %FigureViewer is a discription of parameters for MATLAB graph.
    %
    
    properties
        mode = 0;
        flag = 'initialize';
        
        figure_id;
        n_sub;
        
        layout_x;
		layout_y;
		layout_i;
	    
        manager;
        observers={};
        n_data;
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
			
		end
        
        function setMode(obj)
        end
        
        function setDefault(obj)
        
        end
	end
	
	methods (Static)        
        function obj = init()
			obj = FigureViewer();
        end
    end
end
