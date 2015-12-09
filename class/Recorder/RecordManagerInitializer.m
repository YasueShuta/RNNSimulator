classdef RecordManagerInitializer < ObjectInitializer
	% DATARECORDERINITIALIZER
	%
	properties
		basedir;
		folder;
		idfile;
		
		isValid=false;
	end
	
	methods
		function obj = RecordManagerInitializer(varargin)
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
                        obj.id = [];
					case {'folder', 'dir', 'd'}
						obj.folder = argvdata{i};
                        obj.id = [];
					case {'idfile', 'file', 'f'}
						obj.idfile = argvdata{i};
                        obj.id = [];
					otherwise
				end
            end
			IdManager.reset(obj);
		end
		
		function setDefault(obj)
			obj.basedir = IdManagerDefault.basedir;
			obj.folder = IdManagerDefault.folder;
			obj.idfile = IdManagerDefault.idfile;
            obj.isValid = true;
		end
    end
    
    methods (Static)
        function obj = init(basedir)
            obj = RecordManager('basedir', basedir);
        end
    end
end
