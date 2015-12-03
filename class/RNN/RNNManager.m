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
        
        function notify_stateUpdated(RP, t, nRec2Out)
            notify(RP, 'stateUpdated', STDPEventData(t, nRec2Out));
        end
                
        function obj = createListener(RP)
            obj = RP;
            obj.lh = RP.createListener_inner();
        end
        
        function obj = deleteListener(RP)
            obj = RP;
            delete(obj.lh);
            obj.lh = [];
        end
        
        function obj = setMode(RP)
            obj = RP;
            obj.isPlastic = bitget(obj.mode, 1);
            if obj.isPlastic == true && isempty(obj.lh)
                obj = RNNManager.createListener(RP);
            elseif obj.isPlastic == false && ~isempty(obj.lh)
                obj = RNNManager.deleteListener(RP);
            end
            obj.isLoadedNetwork = bitget(obj.mode, 2);
        end
        
        function obj = defaultRNNProperties()
            if exist('default\rnn.mat', 'file')
                load('default\rnn.mat');
                obj = default_rnn;
            else
                error('defaultRNNProperties: default_rnn does not exist');
            end
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
            if RI.isPlastic
                obj.setPlastic();
            else
                obj.resetPlastic();
            end
        end
        
        function setPlastic(obj)
            if isempty(obj.STDP)
                e = events('RNNSTDPManager');
                obj.STDP = RNNSTDPManager(obj, e(1));
            end
            obj.STDP.createListener();
        end
        
        function resetPlastic(obj)
            if ~isempty(obj.STDP)
                obj.STDP.deleteListener();
            end
        end
        function readout(obj)
            obj.Readout = tanh(obj.Potential);
        end
            
 
    end
end