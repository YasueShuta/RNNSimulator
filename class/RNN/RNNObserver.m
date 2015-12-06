classdef RNNObserver < ObjectObserver
	properties
		isRNNConnected = false;
	end
	
	methods
		function obj = RNNObserver(varargin)
			obj@Observer(varargin);
		end
		
		function target = check_target(obj, target_)
			if isempty(target_) 
				warning('Invalid target: target is not RNN.');
				target_ = [];
				return;
			end
			target = target_;
			obj.isRNNConnected = true;
		end
		
		
	end
end
