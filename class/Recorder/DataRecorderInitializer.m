classdef DataRecorderInitializer < ObjectInitializer
	% DATARECORDERINITIALIZER
	%
	properties
		basedir;
		folder;
		idfile;
		
		isValid;
	end
	
	methods
		function obj = DataRecorder(varargin)
			if nargin == 0
				return;
			end
			obj.set(varargin);
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				return;
			end
			for i = 1:argvnum
				switch argvstr{i}
					case {'basedir', 'base', 'b'}
						obj.basedir = argvdata{i};
					case {'folder', 'dir', 'd'}
						obj.folder = argvdata{i};
					case {'idfile', 'file', 'f'}
						obj.idfile = argvdata{i};
					otherwise
				end
			end
			IdManager.reset(obj);
		end
		
		function setDefault(obj)
			obj.basedir = IdManagerDefault.basedir;
			obj.folder = IdManagerDefault.folder;
			obj.idfile = IdManagerDefault.idfile;
		end
	end
end
