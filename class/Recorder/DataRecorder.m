classdef DataRecorder < DataRecorderInitializer
	% DATARECORDER
	%
	properties
		id;
	
		flag;
        
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
			obj.reset();
		end

		function setId(obj)
   			obj.id = IdManager.getId(obj);
        end
		
		function reset(obj)
            if isempty(obj.id)
    			obj.setId();
            end
            vec = datevec(date);
            obj.dateStr = sprintf('%4d_%02d%02', vec(1), vec(2), vec(3));
        end
        
        function dir = dirname(obj)
            dir = strcat(obj.basedir, '\', obj.folder, '\', obj.dateStr);
        end
    end
end

