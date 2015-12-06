classdef FORCEManager_
    %FORCEManager
    %  for more detail
   
    properties
    end
    
    methods (Static)
        function obj = set(FP, varargin)
            obj = FORCEManager.set_inner(FP, varargin);
        end
        
        function obj = set_inner(FP, argv)
            obj = FP;           
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end            
            for i = 1:argvnum
                switch argvstr{i}
                    case {'alpha', 'a'}
                        obj.alpha = argvdata{i};
                    case {'r_alpha', 'alpha_rate', 'a_rate'}
                        obj.r_alpha = argvdata{i};
                    case {'learn_every', 'le'}
                        obj.learn_every = argvdata{i};
                    case 'mode'
                        obj.mode = argvdata{i};
                    case {'load_wo_name', 'wo_name', 'load_wo'}
                        obj.load_wo_name = argvdata{i};
                        if ~isempty(obj.load_wo_name)
                            FORCEManager.setState(obj, 'isLoadedWeight', 1);
                        end
                    case {'load_wf_name', 'wf_name', 'load_wf'}
                        obj.load_wf_name = argvdata{i};
                        if ~isempty(obj.load_wf_name)
                            FORCEManager.setState(obj, 'isLoadedFeedback', 1);
                        end
                    case 'freq'
                        obj.freq = argvdata{i};
                    case 'amp'
                        obj.amp = argvdata{i};
                    case {'rnn', 'linked_rnn'}
                        obj.linked_rnn = argvdata{i};
                    case {'target_mode'}
                        data = argvdata{i};
                        FORCEManager.setState(obj, 'target_mode_low', bitget(data, 1));
                        FORCEManager.setState(obj, 'target_mode_high', bitget(data, 2));
                    otherwise
                        warning('FORCEProperties: Invalid Argument.');
                end
            end
            FORCEManager.setMode(obj);
        end
        
        function obj = setState(FP, state, o)
            if nargin < 3
                o = true;
            end
            obj = FP;
            switch state
                case {'isTest', 1}
                    b = 1;
                case {'isLoadedWeight', 2}
                    b = 2;
                case {'isLoadedFeedback', 3}
                    b = 3;
                case {'target_mode_low', 4}
                    b = 4;
                case {'target_mode_high', 5}
                    b = 5;                    
                otherwise
                    return;
            end
            obj.mode = bitset(obj.mode, b, o); 
            FORCEManager.setMode(obj);
        end
        
        function obj = setTargetMode(FP, mode)
            obj = FP;
            obj.mode = bitset(obj.mode, 4, mod(mode, 2));
            obj.mode = bitset(obj.mode, 5, mod(bitshift(mode, -1), 2));
        end
        
        function obj = init(FP)
            obj = FP;
            if isempty(FP.linked_rnn)
                error('FORCE init: Link to RNN is Lost.');
            end
            nRec2Out = obj.linked_rnn.n;
            if isempty(FP.alpha)
                FP.alpha = nRec2Out * FP.r_alpha;
            else
                FP.r_alpha = FP.alpha/nRec2Out;
            end
            FORCEManager.initWeight(obj);
            obj.dw = zeros(nRec2Out, 1);
            FORCEManager.initFeedback(obj);
            obj.z0 = 0.5*randn(1,1);
            obj.Output = obj.z0;
            obj.P = (1.0/obj.alpha)*eye(nRec2Out);
            obj.e = 0;
        end
        
        function obj = initWeight(FP, filename)
            obj = FP;
            if FP.isLoadedWeight && nargin == 1
                FORCEManager.loadWeight(FP);
            elseif FP.isLoadedWeight && nargin == 2 && exist(filename, 'file')
                load(filename);
                obj.wo = wo;
            else
                FORCEManager.defaultWeight(FP);
            end
        end
        
        function obj = initFeedback(FP, filename)
            obj = FP;
            if FP.isLoadedFeedback && nargin == 1
                FORCEManager.loadFeedback(FP);
            elseif FP.isLoadedFeedback && nargin == 2 && exist(filename, 'file')
                load(filename);
                obj.wf = wf;
            else
                FORCEManager.defaultFeedback(FP);
            end
        end
        
        function obj = defaultWeight(FP)
            obj = FP;
            obj.wo = zeros(obj.linked_rnn.n, 1);
        end
        
        function obj = defaultFeedback(FP)
            obj = FP;
            obj.wf = 2.0*(rand(obj.linked_rnn.n, 1) - 0.5);
        end
        
        function saveWeight(FP, filename)
            wo = FP.wo;
            save(filename, 'wo');
        end
        
        function saveFeedback(FP, filename)
            wf = FP.wf;
            save(filename, 'wf');
        end
        
        function loadWeight(FP)
            if ~ischar(FP.load_wo_name) || ~exist(FP.load_wo_name, 'file')
                error('Load Error: FORCE Weight does not exist.');
            end
            load(FP.load_wo_name);
            FP.wo = wo;
        end
        
        function loadFeedback(FP)
            if ~ischar(FP.load_wf_name) || ~exist(FP.load_wf_name, 'file')
                error('Load Drror: FORCE Feedback does not exist.');
            end
            load(FP.load_wf_name);
            FP.wf = wf;
        end
            
        function obj = calcOutput(FP)
            obj = FP;
            obj.Output = obj.wo' * obj.linked_rnn.Readout;
        end
        
        function feedback = calcFeedback(FP)
            feedback = FP.wf * FP.Output;
        end
        
        function obj = setMode(FP)
            obj = FP;
            obj.isTest = bitget(obj.mode, 1);
            obj.isLoadedWeight = bitget(obj.mode, 2);
            obj.isLoadedFeedback = bitget(obj.mode, 3);
            obj.target_mode = mod(bitshift(obj.mode, -3), 4);
        end
        
        function obj = setTarget(FP, simtime, option)
            obj = FP;
            if nargin == 2
                option = 0;
            end
            switch obj.target_mode
                case 0
                    FORCEManager.setTarget_Zero(obj, simtime, option);
                case 1
                    FORCEManager.setTarget_Sin(obj, simtime, option);
                case 2
                    FORCEManager.setTarget_Constant(obj, simtime, option);
                otherwise
                    FORCEManager.setTarget_Zero(obj, simtime, option);
            end
        end
        
        function obj = setTarget_Zero(FP, simtime, option)
            obj = FP;
            if option == 0
                obj.targetFunction = zeros(size(simtime));
            elseif option == 1
                obj.targetFunction_forTest = zeros(size(simtime));
            end
        end
                     
        function obj = setTarget_Sin(FP, simtime, option)
            obj = FP;
            if option == 0
                obj.targetFunction = obj.amp * sin(2.0*pi*obj.freq*simtime);
            elseif option == 1
                obj.targetFunction_forTest = obj.amp * sin(2.0*pi*obj.freq*simtime);
            end
        end
        
        function obj = setTarget_Constant(FP, simtime, option)
            obj = FP;     
            if option == 0
                obj.targetFunction = obj.amp * ones(size(simtime));
            elseif option == 1
                obj.targetFunction_forTest = obj.amp * ones(size(simtime));
            end
        end
        
        function obj = updateWeight(FP, SP)
            if ~FP.isTest
                obj = FP;
                r = FP.linked_rnn.Readout;
                k = FP.P * r;
                rPr = r'*k;
                c = 1.0/(1.0 + rPr);
                obj.P = FP.P - k*(k'*c);
            
                obj.e = obj.Output - FP.targetFunction(SP.ti);
            
                obj.dw = -obj.e * k * c;
                obj.wo = FP.wo + obj.dw;
            end
        end
        
        function obj = defaultFORCEProperties()
            if exist('default\force.mat', 'file')
                load('default\force.mat');
                obj = default_force;
            else
                error('defaultFORCEProperties: default_force does not exist. Try: FORCEProperties(''-c'', ''skip'')');
            end
        end
    end
end
