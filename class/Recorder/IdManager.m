classdef IdManager
	properties (Constant)
		setupfile = 'C:\Users\mech-user\Documents\MATLAB\RNNSimulator\testFile\setup.mat';
	end

    methods (Static)
    	function [basedir, folder, idfile] = getSetup(rm)
    		if ~exist(IdManager.setupfile, 'file')
    			if nargin < 1
                    rm = RecordManager.getObject();
                    if isempty(rm)
        				IdManager.setupInit();
                    end
                    IdManager.setupReset(rm);
                else
    				IdManager.setupReset(rm);
    			end
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
		
		function setupReset(rm)
			if nargin < 1 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    IdManager.setupInit();
                    return;
                end
            end
			basedir = rm.basedir;
			folder = rm.folder;
			idfile = rm.idfile;
			
            if ~exist(strcat(basedir, '\', folder), 'dir')
                mkdir(strcat(basedir, '\', folder));
            end
			save(IdManager.setupfile, 'basedir', 'folder', 'idfile');
		end
		    	
        function str = dirname(rm)
        	if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            [basedir, folder, idfile] = IdManager.getSetup(rm);
	        str = strcat(basedir, '\', folder);
	    end

        function str = filename(rm)
        	if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
       		[basedir, folder, idfile] = IdManager.getSetup(rm);
            str = strcat(basedir, '\', folder, '\', idfile);
	    end
	    
        function reset(rm)
            if nargin < 1 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            IdManager.setupReset(rm);
            IdManager.idSave([], [], rm);
        end 
        
        function data = getData(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            dirname = IdManager.dirname(rm);
            filename = IdManager.filename(rm);
            
            if ~exist(dirname, 'dir')
                mkdir(dirname);
            end
            if ~exist(filename, 'file')
                IdManager.reset(rm);
            end
            data = importdata(filename);
        end
        
        function id = getId(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            obj = IdManager.getData(rm);
            id = obj.id + 1;
            IdManager.idSave(obj, 'id', rm);
        end
        function ret = getFileCount(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            obj = IdManager.getData(rm);
            ret = obj.file_count + 1;
            IdManager.idSave(obj, 'file', rm);
        end
        function ret = getFigureCount(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end            
            obj = IdManager.getData(rm)
            ret = obj.figure_count + 1;
            IdManager.idSave(obj, 'figure', rm);
        end
        function ret = getObserverCount(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            obj = IdManager.getData(rm);
            ret = obj.observer_count + 1;
            IdManager.idSave(obj, 'observer', rm);
        end
        function ret = getRecorderCount(rm)
        	if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
        	obj = IdManager.getData(rm);
        	ret = obj.recorder_count + 1;
        	IdManager.idSave(obj, 'recorder', rm);
        end
        
        function idSave(data, str, rm)
            if nargin < 3 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
           	end
           	if nargin < 2 || isempty(str)
           		str = 'reset';
           	end
           	if nargin < 1 || isempty(data)           	
                id = 0;
                file_count = 0;
                figure_count = 0;
                observer_count = 0;
                recorder_count = 0;
            else
            	id = data.id;
                file_count = data.file_count;
                figure_count = data.figure_count;
                observer_count = data.observer_count;
                recorder_count = data.recorder_count;
                switch str
                    case 'id'
                        id = id + 1;
                        file_count = 0;
                        figure_count = 0;
                        observer_count = 0;
                        recorder_count = 0;
                    case 'file'
                        file_count = file_count + 1;
                    case 'figure'
                        figure_count = figure_count + 1;
                    case 'observer'
                        observer_count = observer_count + 1;
                    case 'recorder'
                    	recorder_count = recorder_count + 1;
                    case 'reset'
                        id = 0;
                        file_count = 0;
                        figure_count = 0;
                        observer_count = 0;
                        recorder_count = 0;
                    otherwise
                end
            end
            IdManager.save_safe(IdManager.dirname(rm), IdManager.filename(rm), ...
                id, file_count, figure_count, observer_count, recorder_count);
        end
        
        function save_safe(dirname, filename, id, file_count, figure_count, observer_count, recorder_count)
           if ~exist(dirname, 'dir')
               warning('Invalid Access to directory;');
               mkdir(dirname);
           end
           save(filename, 'id', 'file_count', 'figure_count', 'observer_count', 'recorder_count');
        end
        
        function delete_idfile(rm)
            if nargin == 0 || isempty(rm) || ~rm.isValid
                rm = RecordManager.getObject();
                if isempty(rm)
                    rm = [];
                end
            end
            delete(IdManager.filename(rm));
        end
        
        function delete_setup()
            delete(IdManager.setupfile);
        end
    end
end
