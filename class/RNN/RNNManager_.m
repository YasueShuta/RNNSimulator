classdef RNNManager_ < handle
    %RNNManager Methods to manage RNN Properties.
    %   Ú×à–¾‚ð‚±‚±‚É‹Lq
   
    methods (Static)
        function obj = set(RP, varargin)
            obj = RNNManager.set_inner(RP, varargin);
        end
        
        function obj = set_inner(RP, argv)
            obj = RP;
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case {'N', 'n', 'nRec2Out'}
                        obj.n = argvdata{i};
                    case 'p'
                        obj.p = argvdata{i};
                    case 'g'
                        obj.g = argvdata{i};
                    case {'th', 'threshold'}
                        obj.th = argvdata{i};
                    case 'mode'
                        obj.mode = argvdata{i};
                    case {'load_name', 'load'}
                        obj.load_name = argvdata{i};
                        if ~isempty(obj.load_name)
                            RNNManager.setState(obj, 'isLoadedNetwork', 1);
                        end
                    otherwise
                        warning('RNNProperties: Invalid Argument.');
                end
            end
        end
        
        function obj = setState(RP, state, o)
            if nargin < 3
                o = true;
            end
            obj = RP;
            switch state
                case {'isPlastic', 1}
                    b = 1;
                case {'isLoadedNetwork', 2}
                    b = 2;
                otherwise
                    return;
            end
            obj.mode = bitset(obj.mode, b, o);
            RNNManager.setMode(obj);
        end
                        
        function obj = init(RP)
            obj = RP;
            obj.Scale = 1.0/sqrt(obj.p * obj.n);
            RNNManager.initNetwork(obj);
            RNNManager.initPotential(obj);
            obj.SpikeRecord = zeros(obj.n, 1);
            obj.SpikeTimeRecord = zeros(obj.n, 2);
            obj.dM = zeros(obj.n, obj.n);
        end
        
        function obj = initNetwork(RP, filename)
            obj = RP;
            if RP.isLoadedNetwork && nargin == 1
                RNNManager.loadNetwork(RP);
            elseif RP.isLoadedNetwork && nargin == 2 && exist(filename, 'file')
                load(filename);
                obj.NetworkMatrix = M;
            else
                RNNManager.defaultNetwork(RP);
            end
        end
        
        function obj = defaultNetwork(RP)
            obj = RP;
            M = sprandn(obj.n, obj.n, obj.p)*obj.g*obj.Scale;
            M = full(M);
            obj.NetworkMatrix = M;
        end
        
        function saveNetwork(RP, filename)
            M = RP.NetworkMatrix;
            save(filename, 'M');
        end
        
        function loadNetwork(RP)
            if ~ischar(RP.load_name) || ~exist(RP.load_name, 'file')
                error('Load Error: Network does not exist.');
            end
            load(RP.load_name);
            RP.NetworkMatrix = M;
        end
        
        function obj = initPotential(RP)
            obj = RP;
            obj.x0 = 0.5*randn(RP.n, 1);
            obj.Potential = obj.x0;
            obj.Readout = tanh(obj.Potential);
        end

                        
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
    
end