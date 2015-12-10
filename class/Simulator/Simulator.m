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
                        case {'rootdir'}
                            obj.rootdir = argvdata{i};
						otherwise
					end
				end
			end
			obj.reset();
        end
        
        function setDefault(obj)
            obj.nsecs = SimulatorDefault.nsecs;
            obj.dt = SimulatorDefault.dt;
            obj.rootdir = SimulatorDefault.rootdir;
        end
		
		function reset(obj)
			obj.setSimtime();
			obj.setRecordManager(strcat('testFile\', obj.rootdir));
			obj.setSimulator();
		end
	
    end
    
    methods (Static)
        function obj = init(nsecs, dt, rootdir)
            if nargin < 3 || isempty(rootdir)
                rootdir = SimulatorDefault.rootdir;
            end
            if nargin < 2 || isempty(dt)
                dt = SimulatorDefault.dt;
            end
            if nargin < 1 || isempty(nsecs)
                nsecs = SimulatorDefault.nsecs;
            end
            obj = Simulator('nsecs', nsecs, 'dt', dt, 'rootdir', rootdir);
        end
    end
                
end
