classdef DataRecorder < ObjectInitializer
	% DATARECORDER
	%
	properties
		id;
	
		flag;
		mode = 0;
		savePin;
		
		basedir;
		folder;
		idfile;
		
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
			obj.set(varargin);
			
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				return;
			end
			for i = 1:argvnum
				switch argvstr{i}
					case {'flag'}
						obj.flag = argvdata{i};
					case {'mode'}
						obj.mode = argvdata{i};
					case {'parent', 'p'}
						obj.parent = argvdata{i};
					case {'folder' ,'dir', 'd'}
						obj.folder = argvdata{i};
					otherwise
				end
			end
			obj.setMode();
			obj.reset();
		end
		
		
		
end
