classdef SimulatorFunction < SimulationProperties
	methods (Abstract)
        before_loop(obj);
        after_loop(obj);
        backto_loop(obj);
		loop_once(obj);
		loop_once_test(obj);
	end
	
	methods
		function mainLoop(obj)
            obj.before_loop();
            obj.ti = 0;
			for t = obj.simtime
				obj.t = t;
				obj.ti = obj.ti + 1;
				obj.loop_once();
            end
            obj.after_loop();
		end
		
		function nTimeLoop(obj, n)
			for i = 1:n
				obj.mainLoop();
				obj.backto_loop();
			end
		end
		
		function testLoop(obj)
            obj.backto_loop();
			for t = obj.simtime_test
				obj.t = t;
				obj.ti = obj.ti + 1;
				obj.loop_once_test();
			end
        end
	end
end
