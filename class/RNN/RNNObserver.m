classdef RNNObserver < Observer
	properties
		isRNNConnected = false;
        cellNum = 5;
        cell;
	end
	
	methods
		function obj = RNNObserver(varargin)
            obj.setId();
            if nargin == 0
                return;
            end
            obj.set(varargin);
        end
        
        function set_inner(obj, argvnum, argvstr, argvdata)
            if nargin < 3
                obj.set_inner@Observer(0);
            else
                obj.set_inner@Observer(argvnum, argvstr, argvdata);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case {'cellNum', 'num', 'n'}
                        obj.cellNum = argvdata{i};
                    otherwise
                end
            end
            obj.setCell();
        end
		
		function target = check_target(obj, target_)
			if isempty(target_) 
				warning('Invalid target: target is not RNN.');
				target = [];
				return;
			end
			target = target_;
			obj.isRNNConnected = true;
        end
        
        function check_cellNum(obj)
            if ~obj.isRNNConnected
                return;
            end
            if obj.target.n < obj.cellNum
                obj.cellNum = obj.target.n;
            end
        end
        
        function setCell(obj)
            if ~obj.isRNNConnected
                return;
            end
            obj.check_cellNum();
            obj.cell = randsample(obj.target.n, obj.cellNum);
        end
        
        function str = sprint(obj)
            if ~obj.isRNNConnected
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
            if ~obj.isRNNConnected
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
