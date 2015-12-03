classdef SimulationManager
    %SimulationManager
    %
    
    methods (Static)
        function obj = set(SP, varargin)
            obj = SimulationManager.set_inner(SP, varargin);
        end
        
        function obj = set_inner(SP, argv)
            obj = SP;
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case {'n', 'N', 'nRec2Out'}
                        SP.nRec2Out = argvdata{i};
                        SP.rnn.n = SP.nRec2Out;
                    case 'nsecs'
                        SP.nsecs = argvdata{i};
                    case 'dt'
                        SP.dt = argvdata{i};
                    case 'mode'
                        SP.mode = argvdata{i};
                    case 'rnn_mode'
                        SP.rnn_mode = argvdata{i};
                        SP.rnn.mode = SP.rnn_mode;
                    case 'force_mode'
                        SP.force_mode = argvdata{i};
                        SP.force.mode = SP.force_mode;
                    case 'option'
                        SP.option = argvdata{i};
                    case {'rnn', 'RNN'}
                        SP.rnn = argvdata{i};
                        SP.nRec2Out = SP.rnn.n;
                        SP.rnn_mode = SP.rnn.mode;
                    case {'force', 'FORCE'}
                        SP.force = argvdata{i};
                        SP.force_mode = SP.force.mode;
                    case {'record', 'fr'}
                        SP.record = argvdata{i};
                    case {'viewer', 'fig', 'fv'}
                        SP.viewer = argvdata{i};
                    otherwise
                        warning('SimulationProperties: Invalid Argument.');
                end
            end
            SimulationManager.setFlag(SP, 'uninitialize');
        end
        
        function obj = init(SP)
            obj = SP;
            SimulationManager.setMode(obj);
            SimulationManager.setRNN(obj);
            SimulationManager.setFORCE(obj);
            obj.force.linked_rnn = obj.rnn;
            if obj.nRec2Out ~= obj.rnn.n
                error('Invalid Member.');
            elseif obj.rnn_mode ~= obj.rnn.mode
                obj.rnn_mode = obj.rnn.mode;
            elseif obj.force_mode ~= obj.force.mode
                obj.force_mode = obj.force.mode;
            end
            SimulationManager.setSimtime(obj);
            FORCEManager.setTarget(obj.force, obj.simtime, 0);
            FORCEManager.setTarget(obj.force, obj.simtime_test, 1);
            SimulationManager.setRecord(obj);
            obj.viewer.init();
            SimulationManager.setFlag(obj, 'initialized');
        end
        
        function obj = setRNN(SP)
            obj = SP;
            if isempty(obj.rnn)
                obj.rnn = RNNProperties('n', obj.nRec2Out, 'mode', obj.rnn_mode);
            else
                RNNManager.setMode(obj.rnn);
                RNNManager.init(obj.rnn);
            end
        end
        
        function obj = setFORCE(SP)
            obj = SP;
            if isempty(obj.force)
                obj.force = FORCEProperties('mode', obj.force_mode);
            else
                FORCEManager.setMode(obj.force);
                FORCEManager.init(obj.force);
            end
            if ~isempty(obj.rnn)
                obj.force.linked_rnn = obj.rnn;
            end
        end
        
        function obj = setSimtime(SP)
            obj = SP;
            obj.simtime = 0:obj.dt:obj.nsecs-obj.dt;
            obj.simtime_len = length(obj.simtime);
            obj.simtime_test = 1*obj.nsecs:obj.dt:2*obj.nsecs-obj.dt;
        end
        
        function obj = setRecord(SP)
            obj = SP;
            obj.record = FORCERecorder(SP.simtime, SP.rnn.x0, SP.force.z0);
        end
        
        function obj = setMode(SP)
        end
      
        function obj = setFlag(SP, state)
            obj = SP;
            obj.flag = state;
        end
        
        function obj = defaultSimulationProperties()
            if exist('default\sim.mat', 'file') 
                load('default\sim.mat');
                obj = default_sim;
            else
                error('defaultSimulationProperties: default_sim does not exist');
            end
        end
        
        
        
        function obj = trainInit(SP)
            obj = SP;
            obj.ti = 0;
            obj.rnn.SpikeRecord = zeros(obj.rnn.n, 1);
            obj.rnn.SpikeTimeRecord = zeros(obj.rnn.n, 2);
        end
        
        function obj = trainOnce(SP, t)
            obj = SP;
            obj.t = t;
            obj.ti = obj.ti + 1;
            
            SimulationManager.updateRNN(obj);
            
            if mod(obj.ti, obj.force.learn_every) == 0
                FORCEManager.updateWeight(obj.force, obj);
            end
            
            obj.record.store(obj.ti, obj.rnn, obj.force);
        end
        
        function obj = updateRNN(SP)
            obj = SP;
            feedback = FORCEManager.calcFeedback(SP.force);
            RNNManager.updateRNN(SP.rnn, SP.dt, feedback);
            RNNManager.notify_stateUpdated(SP.rnn, SP.t, SP.nRec2Out);
            FORCEManager.calcOutput(SP.force);
        end
        
        function ret = calcAveErr(SP)
            ret = SP.record.calcAveErr(SP);
        end

    end
end