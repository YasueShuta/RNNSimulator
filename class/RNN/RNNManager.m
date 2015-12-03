classdef RNNManager < handle
    %RNNManager Methods to manage RNN Properties.
    %   Ú×à–¾‚ð‚±‚±‚É‹Lq
    properties (Abstract)
        Potential;
        Readout;
        STDP;
    end
    
    methods (Static)   
        function obj = updateRNN(RP, dt, feedback)
            obj = RP;
            obj.Potential = (1.0-dt)*RP.Potential + RP.NetworkMatrix*(RP.Readout*dt) + feedback*dt;
            obj.Readout = tanh(obj.Potential);
        end
        
        %% for RNNSTDPEvent
        function notify_stateUpdated(RP, t, nRec2Out)
            notify(RP, 'TargetChanged', STDPEventData(t, nRec2Out));
        end

        function obj = setMode(RP)
            obj = RP;
            obj.isPlastic = bitget(obj.mode, 1);
%            if obj.isPlastic == true && isempty(obj.lh)
%                obj = RNNManager.createListener(RP);
%            elseif obj.isPlastic == false && ~isempty(obj.lh)
%                obj = RNNManager.deleteListener(RP);
%            end
            obj.isLoadedNetwork = bitget(obj.mode, 2);
        end
    end
    
    methods
        function reset(obj, RI)
            % obj = RNN, RI = RNNInitializer
            if nargin < 2
                RI = obj;
            elseif obj ~= RI
                obj.copyRNNInitializer(obj, RI);
            end
            obj.Scale = 1/sqrt(RI.n*RI.p);
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
