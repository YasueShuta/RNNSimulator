classdef FigureFunction < handle
	methods
		function plot_data(obj, time, data, color)
			if nargin < 3
				return;
			elseif nargin < 4
				color = 'blue';
            end
			plot(time, data, 'linewidth', obj.linewidth, 'color', color)
		end
		
		function setTitle(obj, str)
			if nargin < 2
				return;
			end
			title(str, 'fontsize', obj.fontsize, 'fontweight', obj.fontweight);
		end
		
		function setXLabel(obj, x_label)
			if nargin < 2
				return;
			end
			xlabel(x_label, 'fontsize', obj.fontsize, 'fontweight', obj.fontweight);
		end
		function setYLabel(obj, y_label)
			if nargin < 2
				return;
			end
			ylabel(y_label, 'fontsize', obj.fontsize, 'fontweight', obj.fontweight);
		end
		function setLegend(obj, varargin)
			if nargin < 2 || isempty(varargin)
				return;
			end
			argv = '';
			for i = 1:length(varargin)
				argv = strcat(argv, '''', varargin{i}, '''');
				if i ~= length(varargin)
					argv = strcat(argv, ', ');
				end
            end
			eval(sprintf('legend(%s);', argv));
		end	
	end
end

