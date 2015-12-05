classdef RNNFunction < RNNProperties
    %RNNManager Methods to manage RNN Properties.
    %   Ú×à–¾‚ð‚±‚±‚É‹Lq
    
    methods   
        function update(obj, dt, t)
            obj.Potential = (1.0-dt)*obj.Potential + obj.NetworkMatrix*(obj.Readout*dt) + obj.Input;
            obj.readout();
            if obj.isPlastic && ~isempty(obj.STDP) && nargin == 3
                obj.STDP.update(t, obj.n)
            end
        end        
       %% for RNNSTDPEvent
        function notify_stateUpdated(RP, t, nRec2Out)
            notify(RP, 'TargetChanged', STDPEventData(t, nRec2Out));
        end
        
        function reset(obj, RI)
            % obj = RNN, RI = RNNInitializer
            if nargin < 2
                RI = obj;
            elseif obj ~= RI
                obj.copyRNNInitializer(obj, RI);
            end
            obj.Scale = 1/sqrt(RI.n*RI.p);
            obj.Input = zeros(RI.n, 1);
            obj.NetworkMatrix = RI.M0;
            obj.Potential = RI.x0;
            obj.readout();
        end        
        
        function setPlastic(obj)
        	if obj.isPlastic == false
        		obj.isPlastic = true;
        	end
        end
        
        function resetPlastic(obj)
        	if obj.isPlastic == true
        		obj.isPlastic = false;
        	end
        end
        
        function readout(obj)
            obj.Readout = tanh(obj.Potential);
        end
    end
end
