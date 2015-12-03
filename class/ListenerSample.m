classdef ListenerSample < handle
    properties
        data=0;
        lh;
    end
    
    events
        MyEvent
    end
    
    methods
        function trigger(obj)
            disp('Trigger');
            notify(obj, 'MyEvent');
        end
        
        function createListener(obj)
            obj.lh = addlistener(obj, 'MyEvent', @callback);
        end
        
        function callback(varargin)
            src = varargin{1};
            disp('Callback');
            src.data = src.data + 1;
            disp(['data: ', num2str(src.data)]);
        end
    end
end

            