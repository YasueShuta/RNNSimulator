classdef Simulator < ObjectInitializer & SimulatorFunction
	properties
		nsecs;
        t;
        ti;
        dt;
        
        simtime;
        simtime_len;
        simtime_test;

        recordManager;      % RecordManager
        rootdir;            % folder = testFile\rootdir
        
%        viewer;             % FigureViewer
	end
	
	methods (Abstract)
		setSimulator(obj);
	end
	
	methods
		function obj = Simulator(varargin)
			obj.set(varargin);
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			obj.setDefault();
			if nargin < 2 || argvnum == 0
			else
				for i = 1:argvnum
					switch argvstr{i}
						case {'nsecs', 'n'}
							obj.nsecs = argvdata{i};
						case {'dt'}
							obj.dt = argvdata{i};
						otherwise
					end
				end
			end
			obj.reset();
		end
		
		function reset(obj)
			obj.setSimtime();
			obj.setRecordManager(strcat('testFile\', obj.rootdir));
			obj.setSimulator();
		end
	
	end
end
