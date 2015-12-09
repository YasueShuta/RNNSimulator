classdef RecordManager < ObjectManager & RecordManagerInitializer
	properties
		id;
	    recorder_count;
	    
        dateStr;
	end
	
	methods
		function obj = RecordManager(varargin)
            tmp = RecordManager.getObject();
            if isempty(tmp)
                % create new RecordManager
                obj.flag = 'updateId';
                obj.set(varargin);
            else
                % modify current RecordManager
                obj = tmp;
                if nargin == 0
                    obj.flag = 'updateId';
                else
                    % if parameter changed, ID require updating
                    obj.set(varargin);
                end 
            end
        end
        
		function set_inner(obj, argvnum, argvstr, argvdata)
            % called after set, set_inner@RecordManagerInitializer
            obj.setDefault();
			if nargin < 2 || argvnum == 0
				obj.set_inner@RecordManagerInitializer(0);
            else
				obj.set_inner@RecordManagerInitializer(argvnum, argvstr, argvdata);
				for i = 1:argvnum
					switch argvstr{i}
						case {'mode', 'm'}
							obj.mode = argvdata{i};
						otherwise
					end
				end
            end
			obj.reset();
		end

		function setId(obj)
            % update id
   			obj.id = IdManager.getId(obj);
        end
		
		function reset(obj)
            IdManager.setupReset(obj);
            if strcmp(obj.flag, 'updateId')
    			obj.setId();
                obj.flag = '';
            end
            vec = datevec(date);
            obj.dateStr = sprintf('%4d_%02d%02d', vec(1), vec(2), vec(3));
        end
        
        function dir = dirname(obj)
            dir = strcat(obj.basedir, '\', obj.folder, '\', obj.dateStr);
        end
        
        function file = filename(obj)
            file = strcat(obj.dirname(), '\', obj.idfile);
        end
        
        function str = timeStr(obj)
            str = datestr(now);
        end
    end

   methods (Static)
       function ret = getObject(tmp)
           if nargin == 0
               tmp = RecordManager.findObjects('RecordManager');
           end
           if isempty(tmp)
               ret = [];
               return;
           end
           ret = tmp{1};
       end
   end
end
