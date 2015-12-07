classdef IdManager
	properties (Constant)
		setupfile = 'C:\Users\mech-user\Documents\MATLAB\RNNSimulator\testFile\setup.mat';
	end
    methods (Static)
    	function [basedir, folder, idfile] = getSetup()
    		if ~exist(IdManager.setupfile)
    			IdManager.setupInit();
    		end
    		setup = importdata(IdManager.setupfile);
    		basedir = setup.basedir;
    		folder = setup.folder;
    		idfile = setup.idfile;
    	end
    	
        function str = dirname(record)
        	if nargin == 0
        		[basedir, folder, idfile] = getSetup();
	            str = strcat(basedir, '\', folder);
	            return;
	        end
	        str = strcat(record.basedir, '\', record.folder);
	    end

        function str = filename(record)
        	if nargin == 0
        		[basedir, folder, idfile] = getSetup();
	            str = strcat(basedir, '\', folder, '\', idfile);
	            return;
	        end
	        str = strcat(record.basedir, '\', folder, '\', record.idfile);
	    end
	    
        function reset()
            IdManager.idSave();
        end 
        
        function data = getData(record)
            if ~exist(IdManager.dirname, 'dir')
                mkdir(IdManager.dirname);
            elseif ~exist(IdManager.filename, 'file')
                IdManager.reset();
            end
            data = importdata(IdManager.filename);
        end
        function id = getId()
            obj = IdManager.getData();
            id = obj.id + 1;
            IdManager.idSave(obj, 'id');
        end
        function ret = getFileCount()
            obj = IdManager.getData();
            ret = obj.file_count + 1;
            IdManager.idSave(obj, 'file');
        end
        function ret = getFigureCount()
            obj = IdManager.getData();
            ret = obj.figure_count + 1;
            IdManager.idSave(obj, 'figure');
        end
        function ret = getObserverCount()
            obj = IdManager.getData();
            ret = obj.observer_count + 1;
            IdManager.idSave(obj, 'observer');
        end
        
        function idSave(data, str)
            if nargin > 0 && ~isempty(data)
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
            else
                id = 0;
                file_count = 0;
                figure_count = 0;
                observer_count = 0;
            end
            save(IdManager.filename, 'id', 'file_count', 'figure_count', 'observer_count');
        end
    end
end
                    
        