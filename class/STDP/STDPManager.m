classdef STDPManager < ObjectManager
    properties (Abstract, Constant)
        deltaT;
    end
    properties
        target;
        trigger;
        dM;
        lh;
    end
    
    methods (Abstract, Static)
        SpikeRecord;
        SpikeTimeRecord;
        Update(t);
    end
    
    methods (Abstract)
        createListener(obj);
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
    end
end
