classdef FORCEObserver < Observer
	properties
		isTargetConnected = false;

		data_wolen;
		data_output;
        data_error;
	end
	
	methods
		function obj = FORCEObserver(varargin)
			obj.set(varargin);
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				obj.set_inner@Observer(0);
			else
				obj.set_inner@Observer(argvnum, argvstr, argvdata);
			end
			obj.reset();
		end
		
		function reset(obj)
			if isempty(obj.id)
				obj.setId();
			end
			obj.isValid = true;
			if strcmp(obj.flag, 'registerRecorder')
				obj.registerRecorder();
			end
		end
		
		%% print functions
		function str = sprint(obj)
			if ~obj.isTargetConnected
				str = 'FORCE is not connected';
				return;
			end
			str = sprintf('\nOutput: % .4f', obj.target.cell.Output);
		end
		
		function data = data(obj)
			if ~obj.isTargetConnected
				data = [];
				return;
			end
			data = zeros(1,3);
			data(1) = obj.target.cell.Output;
            data(2) = obj.target.force.error;
            data(3) = sqrt(obj.target.cn_out.weight * obj.target.cn_out.weight');
        end
        
        %% figure functions
        function initFigureData(obj, simtime)
                obj.data_figure = zeros(size(simtime));
                obj.data_wolen = zeros(size(simtime));
                obj.data_output = zeros(size(simtime));
                obj.data_error = zeros(size(simtime));
        end
        
        function recordFigureData(obj, ti)
            tmp = obj.data;
            obj.data_output(ti) = tmp(1);
            obj.data_error(ti) = tmp(2);
            obj.data_wolen(ti) = tmp(3);
            obj.data_figure(ti) = tmp(1);
        end
            
        function plot_inner(obj, simtime)
            figure(obj.viewer.figure_id);
            subplot 311;
            obj.viewer.plot_data(simtime, obj.target.target, 'green');
            hold on;
            obj.viewer.plot_data(simtime, obj.data_output, 'red');
            obj.viewer.setTitle('FORCE output');
            obj.viewer.setXLabel('time');
            obj.viewer.setYLabel('f and z');
            obj.viewer.setLegend('target', 'output');
            hold off;
            
            subplot 312;
            obj.viewer.plot_data(simtime, obj.data_error);
            hold on;
            obj.viewer.setTitle('FORCE error');
            obj.viewer.setXLabel('time');
            obj.viewer.setYLabel('error');
            hold off;
            
            subplot 313;
            obj.viewer.plot_data(simtime, obj.data_wolen);
            hold on;
            obj.viewer.setTitle('FORCE wolen');
            obj.viewer.setXLabel('time');
            obj.viewer.setYLabel('wolen');
            hold off;
            
        end
    end    
    
    methods (Static)
        function obj = init(target, recorder, viewer)
            if nargin < 1 || isempty(target)
                obj = FORCEObserver();
            else
                if nargin < 2 || isempty(recorder)
                    recorder = DataRecorder();
                end
                if nargin < 3 || isempty(viewer)
                    viewer = FigureViewer();
                end
                obj = FORCEObserver('target', target);
                obj.registerRecorder(recorder);
                obj.registerViewer(viewer);
            end
        end
    end
end