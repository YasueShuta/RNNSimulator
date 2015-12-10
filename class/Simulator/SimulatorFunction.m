classdef SimulatorFunction < SimulationProperties
	methods (Abstract)
		initialize(obj);
		loop_once(obj);
		loop_once_test(obj);
		finalize(obj);
		reset_iter(obj);
	end
	
	methods
		function beforeLoop(obj)
			obj.ti = 0;
			obj.initialize();
		end
		
		function mainLoop(obj)
			for t = obj.simtime
				obj.t = t;
				obj.ti = obj.ti + 1;
				obj.loop_once();
			end
		end
		
		function nTimeLoop(obj, n)
			for i = 1:n
				obj.mainLoop();
				obj.reset_iter();
			end
		end
		
		function testLoop()
			for t = obj.simtime_test
				obj.t = t;
				obj.ti = obj.ti + 1;
				obj.loop_once_test();
			end
		end
		
		function afterLoop(obj)
			obj.finalize();
		end
	end
end
