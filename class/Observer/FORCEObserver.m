classdef FORCEObserver < Observer
	properties
		isTargetConnected = false;
		data_figure;
		data_wolen;
		data_output;
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
			str = sprintf('\nOutput: % .4f', obj.target.Output);
		end
		
		function data = data(obj)
			if ~obj.isTargetConnected
				data = [];
				return;
			end
			data = zeros(1,2);
			data(1) = obj.target.Output
			
end