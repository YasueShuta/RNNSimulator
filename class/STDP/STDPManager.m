classdef STDPManager < ObjectManager
    properties (Abstract, Constant)
        deltaT;
    end
    properties
        target;
        dM;
    end
    
    methods (Abstract, Static)
        SpikeRecord(target);
        SpikeTimeRecord(target, t, n);
        UpdateTarget(target, t, n);
    end
    methods
    	function Update(obj, t, n)
    		obj.SpikeRecord(obj.target);
    		obj.SpikeTimeRecord(obj.target, t, n);
    		if mod(t, obj.deltaT) == 0
    			obj.UpdateTarget(n);
    		end
    	end
    end
end
