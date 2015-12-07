classdef IdManager
	properties (Constant)
		setupfile = 'C:\Users\mech-user\Documents\MATLAB\RNNSimulator\testFile\setup.mat';
	end

    methods (Static)
    	function [basedir, folder, idfile] = getSetup()
    		if ~exist(IdManager.setupfile, 'file')
    			IdManager.setupInit();
    		end
    		setup = importdata(IdManager.setupfile);
    		basedir = setup.basedir;
    		folder = setup.folder;
    		idfile = setup.idfile;
    	end

		function setupInit()
			basedir = IdManagerDefault.basedir;
			folder = IdManagerDefault.folder;
			idfile = IdManagerDefault.idfile;
			
            if ~exist(strcat(basedir, '\', folder), 'dir')
                mkdir(strcat(basedir, '\', folder));
            end
            
			save(IdManager.setupfile, 'basedir', 'folder', 'idfile');
		end
		
		function setupReset(record)
			if nargin < 1 || isempty(record)
				IdManager.setupInit();
			elseif ~record.isValid
				error('Invalid DataRecorder:');
			end
			basedir = record.basedir;
			folder = record.folder;
			idfile = record.idfile;
			
            if ~exist(strcat(basedir, '\', folder), 'dir')
                mkdir(strcat(basedir, '\', folder));
            end
			save(IdManager.setupfile, 'basedir', 'folder', 'idfile');
		end
		    	
        function str = dirname(record)
        	if nargin == 0 || isempty(record) || ~record.isValid
        		[basedir, folder, idfile] = IdManager.getSetup();
	            str = strcat(basedir, '\', folder);
	            return;
	        end
	        str = strcat(record.basedir, '\', record.folder);
	    end

        function str = filename(record)
        	if nargin == 0 || isempty(record) || ~record.isValid
        		[basedir, folder, idfile] = IdManager.getSetup();
	            str = strcat(basedir, '\', folder, '\', idfile);
	            return;
	        end
	        str = strcat(record.basedir, '\', record.folder, '\', record.idfile);
	    end
	    
        function reset(record)
            if nargin < 1 || isempty(record)
                record = [];
            end
            IdManager.setupReset(record);
            IdManager.idSave([], [], record);
        end 
        
        function data = getData(record)
            if nargin == 0 || isempty(record)
                record = [];
            end
            dirname = IdManager.dirname(record);
            filename = IdManager.filename(record);
            
            if ~exist(dirname, 'dir')
                mkdir(dirname);
            elseif ~exist(filename, 'file')
                IdManager.reset();
            end
            data = importdata(filename);
        end
        
        function id = getId(record)
            if nargin == 0 || isempty(record)
                record = [];
            end
            obj = IdManager.getData(record);
            id = obj.id + 1;
            IdManager.idSave(obj, 'id', record);
        end
        function ret = getFileCount(record)
            if nargin == 0 || isempty(record)
                record = [];
            end
            obj = IdManager.getData(record);
            ret = obj.file_count + 1;
            IdManager.idSave(obj, 'file', record);
        end
        function ret = getFigureCount(record)
            if nargin == 0 || isempty(record)
                record = [];
            end            
            obj = IdManager.getData(record);
            ret = obj.figure_count + 1;
            IdManager.idSave(obj, 'figure', record);
        end
        function ret = getObserverCount(record)
            if nargin == 0 || isempty(record)
                record = [];
            end
            obj = IdManager.getData(record);
            ret = obj.observer_count + 1;
            IdManager.idSave(obj, 'observer', record);
        end
        
        function idSave(data, str, record)
            if nargin < 3 || isempty(record) 
            	record = [];
           	end
           	if nargin < 2 || isempty(str)
           		str = 'reset';
           	end
           	if nargin < 1 || isempty(data)           	
                id = 0;
                file_count = 0;
                figure_count = 0;
                observer_count = 0;
            else
            	id = data.id;
                file_count = data.file_count;
                figure_count = data.figure_count;
                observer_count = data.observer_count;
                switch str
                    case 'id'
                        id = id + 1;
                        file_count = 0;
                        figure_count = 0;
                        observer_count = 0;
                    case 'file'
                        file_count = file_count + 1;
                    case 'figure'
                        figure_count = figure_count + 1;
                    case 'observer'
                        observer_count = observer_count + 1;
                    case 'reset'
                        id = 0;
                        file_count = 0;
                        figure_count = 0;
                        observer_count = 0;
                    otherwise
                end
            end
            IdManager.save_safe(IdManager.dirname(record), IdManager.filename(record), ...
                id, file_count, figure_count, observer_count);
        end
        
        function save_safe(dirname, filename, id, file_count, figure_count, observer_count)
           if ~exist(dirname, 'dir')
               warning('Invalid Access to directory;');
               mkdir(dirname);
           end
           save(filename, 'id', 'file_count', 'figure_count', 'observer_count');
        end
        
        function delete_idfile(record)
            if nargin == 0 || isempty(record) || ~record.isValid
                record = [];
            end
            delete(IdManager.filename(record));
        end
        
        function delete_setup()
            delete(IdManager.setupfile);
        end
    end
end
