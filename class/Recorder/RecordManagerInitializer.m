classdef RecordManagerInitializer < ObjectInitializer
	% DATARECORDERINITIALIZER
	%
	properties
		basedir;
		folder;
		idfile;
		
        flag = '';
		isValid=false;
    end
	
	methods
		function obj = RecordManagerInitializer(varargin)
            if strcmp(class(obj), 'RecordManagerInitializer')
                obj.set(varargin);
            else
                return;
            end
        end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			if nargin < 2 || argvnum == 0
				return;
            end
			for i = 1:argvnum
				switch argvstr{i}
					case {'basedir', 'base', 'b'}
                        if ~isempty(obj.basedir) && ~strcmp(obj.basedir, argvdata{i})
                            obj.flag = 'updateId';
                        end
						obj.basedir = argvdata{i};
                    case {'folder', 'dir', 'd'}
                        if ~isempty(obj.folder) && ~strcmp(obj.folder, argvdata{i})
                            obj.flag = 'updateId';
                        end
						obj.folder = argvdata{i};    
                    case {'idfile', 'file', 'f'}
                        if ~isempty(obj.folder) && ~strcmp(obj.idfile, argvdata{i})
                            obj.flag = 'updateId';
                        end
						obj.idfile = argvdata{i};
                    case {'flag'}
    					obj.flag = argvdata{i};
                    otherwise
                end
            end
		end
		
		function setDefault(obj)
            [basedir, folder, idfile] = IdManager.getSetup();
			obj.basedir = basedir;
			obj.folder = folder;
			obj.idfile = idfile;
            obj.isValid = true;
        end 
    end
    
    methods (Static)
        function obj = init(folder)
            if nargin < 1
                obj = RecordManager();
            else
                obj = RecordManager('folder', folder);
            end
        end
    end
end
