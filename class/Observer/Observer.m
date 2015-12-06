classdef Observer < ObjectInitializer
	properties
		target;
		output_mode = 'invalid';
		
		every;
		recorder;
		dstfile;
		dstdir;
	end
	
	methods (Abstruct)
		check_target(obj, target_);
	end
	
	methods
		function obj = Observer(varargin)
			if nargin == 0
				return;
			end
			obj = Observer();
			obj.set(varargin);
		end
	
		function set_inner(obj, argvnum, argvstr, argvdata)
			for i = 1:argvnum
				switch argv{i}
					case {'target', 't'}
						obj.target = obj.check_target(argvdata{i});
					case {'output_mode', 'mode', 'm'}
						obj.output_mode = obj.check_mode(argvdata{i});
					case {'every', 'e'}
						obj.every = argvdata{i};
					case {'recorder', 'r'}
						obj.recorder = obj.check_recorder(argvdata{i});
					case {'dstfile', 'file', 'f'}
						obj.dstfile = argvdata{i};
					case {'dstdir', 'dir', 'd'}
						obj.dstdir = argvdata{i};
					otherwise
				end
			end
			obj.setMode();
		end
		
		function set_Mode(obj)
			if isempty(target)
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
		
		function rec = check_recorder(obj, rec_)
			if isempty(rec_) || isempty(findprop(rec_, 'isValid')) || isValid == false
				warning('Invalid recorder:');
				obj.mode = 'default';
				rec = [];
			else
				rec = rec_;
			end
		end
	end
end
