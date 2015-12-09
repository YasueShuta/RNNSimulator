classdef DataRecorderInitializer < ObjectInitializer
	% DATARECORDERINITIALIZER
	%
	properties		
		isValid=false;
        flag = 'initialize';
        
		observer;
		recordName='data';
	end
	
	methods
		function obj = DataRecorderInitializer(varargin)
            if strcmp(class(obj), 'DataRecorderInitializer')
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
                    case {'observer', 'o'}
                        obj.observer = argvdata{i};
                        obj.flag = 'registerObserver';
                    case {'recordName', 'name', 'n'}
                        obj.recordName = argvdata{i};
                    case {'flag'}
                        obj.flag = argvdata{i};
					otherwise
				end
            end
        end
    end
    
    methods (Static)
        function obj = init(observer)
            if nargin < 1 || isempty(observer)
                obj = DataRecorder();
            else
                obj = DataRecorder('observer', observer);
            end
        end
    end
end
