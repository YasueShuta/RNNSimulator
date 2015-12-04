classdef STDPEvent < handle
    properties (Abstract, Constant)
        deltaT;
    end
    properties
        target;
        trigger;
        dM;
        lh;
    end
    
    events
    	TargetChenged
    end
    
    methods (Abstract, Static)
        SpikeRecord;
        SpikeTimeRecord;
        UpdateTarget(t);
    end
    
    methods
        function UpdatedCallback(eventSrc, eventData)
            eventSrc.SpikeRecord(eventSrc.target);
            eventSrc.SpikeTimeRecord(eventSrc.target, eventData.t, eventData.n);
            if mod(eventData.t, eventSrc.deltaT) == 0
                eventSrc.Update(eventData.n);
            end
        end
        function deleteListener(obj)
            delete(obj.lh);
            obj.lh = [];
        end
        function createListener(obj)
        	obj.lh = event.listener(obj, obj.trigger, @UpdatedCallback);
        end
    end
end
