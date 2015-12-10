classdef RNNObserverSet < ObjectInitializer
    properties
        observer;
        recorder;
        viewer;
    end
    
    methods
        function obj = RNNObserverSet(varargin)
            obj.set(varargin);
        end
        
        function set_inner(obj, argvnum, argvstr, argvdata)
            if isempty(obj.recorder)
                obj.recorder = DataRecorder();
            end
            if isempty(obj.observer)
                obj.observer = RNNObserver('recorder', obj.recorder);
            end
            
            if nargin < 2 || argvnum == 0
                obj.observer.set_inner(0);
                obj.recorder.set_inner(0);
            else
                obj.observer.set_inner(argvnum, argvstr, argvdata);
                obj.recorder.set_inner(argvnum, argvstr, argvdata);
            end
            obj.reset();
        end
        
        function reset(obj)
            obj.observer.reset();
            obj.recorder.reset();
        end
    end
    
    methods (Static)
        function obj = init(target, name)
            if nargin < 2 || isempty(name)
                name = [];
            end
            if nargin < 1 || isempty(target)
                obj = RNNObserverSet('recordName', name);
            else
                obj = RNNObserverSet('target', target, 'recordName', name);
            end
        end
    end
end