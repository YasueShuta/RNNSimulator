classdef RNNObserver < Observer
	properties
		isTargetConnected = false;
        cellNum = 5;
        cell;
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
            if strcmp(obj.flag, 'registerRecorder')
                obj.registerRecorder();
            end
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
            data = zeros(1, obj.cellNum);
            for i = 1:obj.cellNum
                data(i) = obj.target.Readout(obj.cell(i));
            end
        end
    end
    
    methods (Static)    
        function obj = init(target, recorder)
            if nargin < 1
                obj = RNNObserver();
            elseif nargin < 2
                obj = RNNObserver('target', target);
            else
                obj = RNNObserver('target', target, 'recorder', recorder);
            end
        end
    end
end
