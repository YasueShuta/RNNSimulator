classdef RecorderFunction < handle
    properties (Abstract)
        manager;
        recordId;
        recordName;
        file_count;
        data_count;
        logfile;
    end
    
    methods (Abstract)
        
    end
    
    methods
        function print(obj, str, filename)
            if nargin < 2
                error('Invalid Argument:');
            elseif nargin == 2
                filename = obj.logfile;
            end
            
            if isempty(filename) || ~exist(filename, 'file')
                fid = obj.log_init();
            else
                fid = fopen(filename, 'a');
            end
            fprintf(fid, str);
            fprintf(fid, '\n');
            fclose(fid);
        end
           
        function fid = log_init(obj)
            dirname = obj.dirName('log');
            if ~exist(dirname, 'dir')
               mkdir(dirname);
            end
            obj.logfile = strcat(dirname, '\', obj.idStrShort, obj.recordName, '.txt');
            fid = fopen(obj.logfile, 'w');
            fprintf(fid, obj.timeStr());
            fprintf(fid, '|\n\n');
        end
        
        function save(obj, data, name, dir)
            if nargin == 4
                filename = obj.saveFileName(name, dir);
            elseif nargin == 3
                filename = obj.saveFileName(name);
            else
                filename = obj.saveFileName();
            end
            save(filename, 'data');       
        end
        
        function str = dirName(obj, dir)
            if nargin == 2
                str = strcat(obj.manager.dirname, '\', dir);
            else
                str = strcat(obj.manager.dirname, '\data');
            end
        end
        
        function str = saveFileName(obj, name, dir)
            if nargin == 3
                dirname = obj.dirName(dir);
                filename = strcat(obj.idStrShort, name, '.mat');
            elseif nargin == 2
                dirname = obj.dirName();
                filename = strcat(obj.idStrShort, name, '.mat');
            else
                obj.file_count = IdManager.getFileCount();
                dirname = obj.dirName();
                filename = strcat(obj.idStrLong,  'data.mat');
            end
            if ~exist(dirname, 'dir')
                mkdir(dirname);
            end
            str = strcat(dirname, '\', filename);
        end
        
        function str = loadFileName(obj, name, dir)
            if nargin == 2
                dirname = obj.dirName(dir);
            else
                dirname = obj.dirName();
            end
            str = strcat(dirname, '\', name);
        end
        
        function str = idStrShort(obj)
           % id, recordId
           vec = obj.id_vector;
           str = sprintf('%02d%02d', vec(1), vec(2));
        end
        
        function str = idStrLong(obj)
            vec = obj.id_vector;
            str = sprintf('%02d%02d_%04d', vec(1), vec(2), vec(3));
        end
        
        function vec = id_vector(obj)
            vec = zeros(1, 4);
            vec(1) = obj.manager.id;
            vec(2) = obj.recordId;
            vec(3) = obj.file_count;
            vec(4) = obj.data_count;
        end
    end
    
    methods (Static)
        function str = timeStr()
            str = datestr(now);
        end
    end
end