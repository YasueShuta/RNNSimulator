classdef RNNFunction < RNNProperties
    
    %RNNManager Methods to manage RNN Properties.
    %   Ú×à–¾‚ð‚±‚±‚É‹Lq
    methods   
        function update(obj, dt, t)
            obj.Potential = (1.0-dt)*obj.Potential + obj.NetworkMatrix*(obj.Readout*dt) + obj.Input;
            obj.readout();
            if nargin == 3
	            obj.networkUpdate(t);
	        end
        end        
       %% for RNNSTDPEvent
        function notify_stateUpdated(RP, t, nRec2Out)
            notify(RP, 'TargetChanged', STDPEventData(t, nRec2Out));
        end
        
        function networkUpdate(obj, t)
            if obj.isPlastic && ~isempty(obj.STDP) && nargin == 2
                obj.STDP.update(t, obj.n)
            end
        end
        
    end
end
