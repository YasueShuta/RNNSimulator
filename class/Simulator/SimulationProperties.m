classdef SimulationProperties < handle
    %SimulationProperties
    %
    
    properties (Abstract)
        nsecs;
        t;
        ti;
        dt;
        
        simtime;
        simtime_len;
        simtime_test;

        recordManager;      % RecordManager
%        viewer;             % FigureViewer
    end
    
    methods
    	function setSimtime(obj)
    		obj.simtime = 1:obj.dt:obj.nsecs-obj.dt;
    		obj.simtime_len = length(obj.simtime);
    		obj.simtime_test = obj.nsecs:obj.dt:2*obj.nsecs-obj.dt;
    	end
    	
    	function setRecordManager(obj, basedir, folder, idfile)
    		if nargin < 4 || isempty(idfile)
    			idfile = '';
    		end
    		if nargin < 3 || isempty(folder)
    			folder = '';
    		end
    		if nargin < 2 || isempty(basedir)
    			basedir = '';
    		end
    		evalin('base', sprintf('recordManager = RecordManager(%s);', folder));
    		obj.recordManager = RecordManager.getObject();
    	end
    end
end

