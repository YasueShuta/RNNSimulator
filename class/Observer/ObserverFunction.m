classdef ObserverFunction < handle
    properties (Abstract)
        output_mode;
        
        every;
        recorder;
        dstfile;
    end
    
    methods (Abstract) 
        sprint(obj);
        data(obj);
    end
    
    methods
   		function print(obj)
			switch(obj.output_mode)
				case 'invalid'
                    warning('Invalid Observer:');
					return;
				case 'console'
					obj.print_console(obj.sprint());
                case 'recorder'
                    obj.print_recorder(obj.sprint());
                case 'file'
                    obj.print_file(obj.sprint());
				otherwise;
            end
        end
        
        function print_console(obj, str)
            disp([sprintf('[%02d] ',obj.id), str]);
        end
        
        function print_recorder(obj, str)
            obj.recorder.print(str);
            %print_console(obj, strcat('recorder:', str));
        end
        
        function print_file(obj, str)
            if ~exist(obj.dstfile, 'file')
                fid = obj.file_init();
            else
                fid = fopen(obj.dstfile, 'a');
            end
            fprintf(fid, str);
            fclose(fid);
        end
        
        function fid = file_init(obj)
            fid = fopen(obj.dstfile, 'w');
            fprintf(fid, obj.timeStr());
        end
    end
    
    methods (Static)
        function str = timeStr()
            str = datestr(now);
        end
    end     
end