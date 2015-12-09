classdef Observer < ObjectInitializer & ObserverFunction
	properties
        id;
        
		target;
		output_mode = 'invalid';
        
        isValid=false;
		flag = 'initialize';
        
		every = 10;
		recorder;
		dstfile;
		dstdir;
	end
	
	methods
        function setId(obj, rm)
        	if nargin < 2 || isempty(rm) || ~rm.isValid
        		rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
        	end
            obj.id = IdManager.getObserverCount(rm);
        end
		function set_inner(obj, argvnum, argvstr, argvdata)
			for i = 1:argvnum
				switch argvstr{i}
					case {'target', 't'}
						obj.target = obj.check_target(argvdata{i});
					case {'output_mode', 'mode', 'm'}
						obj.output_mode = obj.check_mode(argvdata{i});
					case {'every', 'e'}
						obj.every = argvdata{i};
					case {'recorder', 'r'}
						obj.recorder = argvdata{i};
                        obj.flag = 'registerRecorder';
					case {'dstfile', 'file', 'f'}
						obj.dstfile = argvdata{i};
					otherwise
				end
			end
			obj.setMode();
		end
		
		function setMode(obj)
			if isempty(obj.target)
				obj.output_mode = 'invalid';
				return;
			elseif ~isempty(obj.recorder)
				obj.output_mode = 'recorder';
			elseif ~isempty(obj.dstdir) && ~isempty(obj.dstfile)
				obj.output_mode = 'file';
			else
				obj.output_mode = 'console';
			end
		end
		
		function mode = check_mode(obj, mode_)
			if strcmp(mode_, 'default') || strcmp(mode_, 'console') || strcmp(mode_, 'recorder') || strcmp(mode_, 'file')
				mode = mode_;
			else
				warning('Invalid mode:');
				mode = 'default';
			end
		end
		
		function registerRecorder(obj)
			if isempty(obj.recorder) || ~obj.recorder.isValid
				warning('recorder is not ready');
				obj.mode = 'default';
                return;
            end
            if isempty(obj.recorder.observer) || obj.recorder.observer.id ~= obj.id
                obj.recorder.set('observer', obj);
            end
            obj.flag = '';
        end
  		
		function target = check_target(obj, target_)
			if isempty(target_) 
				warning('Invalid target: target is not RNN.');
				target = [];
				return;
			end
			target = target_;
			obj.isTargetConnected = true;
        end
    end
end
