classdef ObserverFigure < handle
	properties (Abstract)
		figure_every;
		
		viewer;
		data_figure;
	end
	
	methods (Abstract)
		plot_inner(obj, simtime);
        initFigureData(obj, simtime);
        recordFigureData(obj, ti);
	end
	methods
        function registerViewer(obj, viewer)
            if ~isempty(obj.viewer)
                return;
            end
            obj.viewer = viewer;
            obj.flag = 'initFigureData';
            viewer.register(obj);
        end
        
		function plot(obj, simtime, ti, isSample)
			if isempty(obj.viewer)
				return;
			end
			if nargin >= 3 && mod(ti, obj.figure_every) ~= 0
				return;
			end
			if nargin < 4 || ~isSample
				obj.plot_inner(simtime);
			else
				obj.plot_inner_sample(simtime);
			end
		end
		
		function plot_inner_sample(obj, simtime)
			figure(obj.viewer.figure_id);
			obj.viewer.plot_data(simtime, obj.data_figure);
			obj.viewer.setTitle('Sample');
		end
	end
end
