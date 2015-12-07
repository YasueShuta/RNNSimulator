classdef DataRecorder < DataRecorderInitializer
	% DATARECORDER
	%
	properties
		id;
	
		flag;
		mode = 0;
		savePin;
		
        dateStr;
		recordName='data';
	end
	
	methods
		function obj = DataRecorder(varargin)
			if nargin == 0
				obj.set();
            end
			obj.set(varargin);
        end
        
		function set_inner(obj, argvnum, argvstr, argvdata)
            obj.setDefault();
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
                        case {'name', 'recordName', 'n'}
                            obj.recordName = argvdata{i};
						otherwise
					end
				end
			end
			obj.setMode();
			obj.reset();
		end

		function setId(obj)
   			obj.id = IdManager.getId(obj);
		end
		
		function setMode(obj)
            obj.savePin = DataRecorderPin(obj.mode);
		end
		
		function reset(obj)
            if isempty(obj.id)
    			obj.setId();
            end
        end
        
        
    end	
end

