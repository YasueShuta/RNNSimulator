classdef RNNObserver < Observer
	properties
		isRNNConnected = false;
	end
	
	methods
		function obj = RNNObserver(varargin)
            if nargin == 0
                return;
            end
            obj.set(varargin);
		end
		
		function target = check_target(obj, target_)
			if isempty(target_) 
				warning('Invalid target: target is not RNN.');
				target = [];
				return;
			end
			target = target_;
			obj.isRNNConnected = true;
		end
		
        function str = sprint(obj)
            str = 'undefined';
        end
	end
end
