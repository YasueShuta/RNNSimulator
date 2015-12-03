classdef (ConstructOnLoad) STDPEventData < event.EventData
    properties
        t;
        n;
    end
    
    methods
        function stdpEventData = STDPEventData(t, n)
           stdpEventData.t = t;
           stdpEventData.n = n;
        end
    end
end
