classdef DataRecorder < DataRecorderInitializer
	% DATARECORDER
	%
	properties
		recordId;
        file_count;
	    
		manager;
	end
	
	methods
		function obj = DataRecorder(varargin)
			obj.set(varargin);
        end
        
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				obj.set_inner@DataRecorderInitializer(0);
            else
				obj.set_inner@DataRecorderInitializer(argvnum, argvstr, argvdata);
				for i = 1:argvnum
					switch argvstr{i}
						case {'mode'}
							obj.mode = argvdata{i};
                        case {'name', 'recordName', 'n'}
                            obj.recordName = argvdata{i};
						otherwise
					end
				end
            end
			obj.reset();
		end

		function setId(obj)
   			obj.recordId = IdManager.getRecorderCount(obj.manager);
        end
		
		function reset(obj)
            if isempty(obj.recordId)
    			obj.setId();
                obj.file_count = 0;
            end
            rm = RecordManager.getObject();
            if isempty(rm)
                warning('RecordManager is not defined.');
                evalin('base', 'recordManager_ = RecordManager();');
                rm = RecordManager.getObject();
            end
            obj.manager = rm;
            obj.isValid = true;
            if strcmp(obj.flag, 'registerObserver')
                obj.registerObserver();
            end
        end
        
        function registerObserver(obj)
            if isempty(obj.observer) || ~obj.observer.isValid
                warning('Observer is not ready.');
                return;
            end
            if isempty(obj.observer.recorder) || obj.observer.recorder.recordId ~= obj.recordId
                obj.observer.set('recorder', obj);
            end
            obj.flag = '';
        end
    end
end

