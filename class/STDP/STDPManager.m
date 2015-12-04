classdef STDPManager < ObjectManager
    properties (Abstract, Constant)
        deltaT;
    end
    properties
        target;
        dM;
    end
    
    methods (Abstract, Static)
        recordSpike(target);
        recordSpikeTime(target, t, n);
        updateTarget(target, t, n);
    end
    methods
    	function update(obj, t, n)
    		obj.recordSpike(obj.target);
    		obj.recordSpikeTime(obj.target, t, n);
    		if mod(t, obj.deltaT) == 0
    			obj.updateTarget(n);
    		end
    	end
    end
end
