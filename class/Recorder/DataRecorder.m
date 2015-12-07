classdef DataRecorder < DataRecorderInitializer
	% DATARECORDER
	%
	properties
		id;
		isValid;
	
		flag;
		mode = 0;
		savePin;
		
		saveDir;
		currDir;
		dateStr;
		
		recordName;
	end
	
	methods
		function obj = DataRecorder(varargin)
			if nargin == 0
				return;
			end
			obj.setDefault();
			obj.isValid = true;
			obj.set(varargin);
			
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				obj.set_inner@DataRecorderInitializer(0);
			else
				obj.set_inner@DataRecorderInitializer(argvnum, argvstr, argvdata);
				for i = 1:argvnum
					switch argvstr{i}
						case {'flag'}
							obj.flag = argvdata{i};
						case {'mode'}
							obj.mode = argvdata{i};
						otherwise
					end
				end
			end
			obj.setId();
			obj.setMode();
			obj.reset();
			end
		end

		function setId(obj)
			obj.id = IdManager.getId(obj);
		end
		
		function setMode(obj)
		
		end
		
		function reset(obj)
			
		end		
	end	
end
