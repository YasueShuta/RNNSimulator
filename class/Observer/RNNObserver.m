classdef RNNObserver < Observer
	properties
		isTargetConnected = false;
        cellNum = 10;
        cell;
        
        dataCell_x;
        dataCell_r;
	end
	
	methods
		function obj = RNNObserver(varargin)
            obj.set(varargin);
        end
        
        function set_inner(obj, argvnum, argvstr, argvdata)
            if nargin < 2 || argvnum == 0
                obj.set_inner@Observer(0);
            else
                obj.set_inner@Observer(argvnum, argvstr, argvdata);
                for i = 1:argvnum
                    switch argvstr{i}
                        case {'cellNum', 'num', 'n'}
                            obj.cellNum = argvdata{i};
                        otherwise
                    end
                end
            end
            obj.reset();
        end
        
        function reset(obj)
            if isempty(obj.id)
                obj.setId();
            end
            if obj.isTargetConnected
                obj.setCell();
            end
            obj.isValid = true; 
        end
        
        function setCell(obj)
            if ~obj.isTargetConnected
                return;
            end
            if obj.target.n < obj.cellNum
                obj.cellNum = obj.target.n;
            end
            obj.cell = randsample(obj.target.n, obj.cellNum);
        end
        
        %% print functions
        function str = sprint(obj)
            if ~obj.isTargetConnected
                str = 'RNN is not connected';
                return;
            end
            str = sprintf('\n');
            dat = '';
            for i = 1:obj.cellNum
                str = strcat(str, sprintf('\t\t   (%02d)', obj.cell(i)));
                dat = strcat(dat, sprintf('\t\t% .4f', obj.target.Readout(obj.cell(i))));
            end
            str = sprintf('%s\n[x:]%s', str, dat);
        end
        
        function data = data(obj)
            if ~obj.isTargetConnected
            	data = [];
                return;
            end
            data = zeros(2, obj.cellNum);
            for i = 1:obj.cellNum
            	data(i, 1) = obj.target.Potential(obj.cell(i)); 
                data(i, 2) = obj.target.Readout(obj.cell(i));
            end
        end
        
        %% figure functions
        function initFigureData(obj, simtime)
        	obj.data_figure = zeros(size(simtime));
        	obj.dataCell_x = cell(1, obj.cellNum);
        	obj.dataCell_r = cell(1, obj.cellNum);
        	for i = 1:obj.cellNum
        		obj.dataCell_x{i} = zeros(size(simtime));
        		obj.dataCell_r{i} = zeros(size(simtime));
        	end
        end
        
        function recordFigureData(obj, ti)
        	tmp = obj.data;
        	for i = 1:obj.cellNum
        		obj.dataCell_x{i}(ti) = tmp(i, 1);
        		obj.dataCell_r{i}(ti) = tmp(i, 2);
        	end
        	obj.data_figure(ti) = tmp(1, 1);
        end
        
        function plot_inner(obj, simtime)
			argv = '';
			for i = 1:obj.cellNum
				argv = strcat(argv, ' '' ', num2str(obj.cell(i)), ' '' ');
				if i ~= obj.cellNum
					argv = strcat(argv, ', ');
				end
			end
			
        	figure(obj.viewer.figure_id);
        	subplot 211;
			obj.viewer.plot_data(simtime, obj.dataCell_x{1}, obj.viewer.manager.colorSet{2});
			hold on;
			obj.viewer.setTitle('innerRNN');
			obj.viewer.setXLabel('time');
			obj.viewer.setYLabel('potential');
			for i = 2:obj.cellNum
				obj.viewer.plot_data(simtime, obj.dataCell_x{i}, ...
					obj.viewer.manager.colorSet{mod(i, obj.viewer.manager.colorSetNum)+1});
			end
			eval(sprintf('obj.viewer.setLegend(%s)', argv)); 
			hold off;
			    
			subplot 212;
			obj.viewer.plot_data(simtime, obj.dataCell_r{1}, obj.viewer.manager.colorSet{2});
			hold on;
			obj.viewer.setTitle('innerRNN');
			obj.viewer.setXLabel('time');
			obj.viewer.setYLabel('readout');
			for i = 2:obj.cellNum
				obj.viewer.plot_data(simtime, obj.dataCell_r{i}, ...
					obj.viewer.manager.colorSet{mod(i, obj.viewer.manager.colorSetNum)+1});
			end
			eval(sprintf('obj.viewer.setLegend(%s)', argv)); 
			hold off;
        end
    end
    
    methods (Static)    
        function obj = init(target, recorder, viewer)
            if nargin < 1 || isempty(target)
                obj = RNNObserver();
            else
                if nargin < 2 || isempty(recorder)
                    recorder = DataRecorder();
                end
                if nargin < 3 || isempty(viewer)
                    viewer = FigureViewer();
                end
                obj = RNNObserver('target', target);
                obj.registerRecorder(recorder);
                obj.registerViewer(viewer);
            end
        end
    end
end
