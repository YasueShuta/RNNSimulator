classdef FreqTest < handle
    properties
        mode = 0;
        
        N = 32;
        nsecs = 144 * 3;
        dt = 0.1;
        
        isPlastic = false;
        target_mode = 1; 
        freq = 1/144 * 10;
        amp = 0.6;
        sim_mode = 0;
        rnn_mode = 0;
        force_mode = 0;
        
        load_rnn;
        load_wo;
        load_wf;
        
        skip_record;
        skip_disp;
        skip_figure;
        skip_save;
        
        flag;
        
        ave_err;
        
        figureIDs;
        
        recorder;    % DataRecorder
        sim;         % SimulationProperties
        fig;         % FigureViewer
    end

    methods (Static)
        function obj = main()
            clear;
            mypath();
            
            isPlastic_ = true;
            freq_ = 1/144 / 10;
            
            obj = FreqTest();
            obj.set('dt', 0.01, 'isPlastic', isPlastic_, 'freq', freq_);
%            setFlag(obj.fig, 'all');            
            obj.setState('skip_figure');
            obj.fig.init();
            obj.recorder.setState('save_aveerr');
            obj.recorder.setState('save_test');
            obj.init();
            DisplayManager.dispAll(obj.sim, obj.skip_disp);
            
            obj.trainingLoop();
            
            obj.recordAveErr();
            
            obj.recorder.saveAuto(obj.sim);
                        
%            FORCEManager.setTargetMode(force, obj.target_mode);
%            FORCEManager.set(force, 'freq', obj.freq, 'amp', obj.amp);

        end
        
        function [ave_err, obj] = freqTest(f, p)
            obj = FreqTest('dt', 0.01, 'isPlastic', p, 'freq', f, 'mode', 6);
            obj.recorder.setState('save_aveerr');
            obj.recorder.setState('save_test');
            DisplayManager.dispAll(obj.sim, obj.skip_disp);
            
            obj.trainingLoop();            
            obj.recordAveErr();
            ave_err = obj.ave_err;
            obj.saveTest();
            obj.recorder.saveAuto(obj.sim);
        end
        
        function [ave_err, obj] = freqTest2(f, p, folder) % folder = 'testFile\freqres\non_plastic'
            obj = FreqTest('dt', 0.01, 'isPlastic', p, 'freq', f, 'mode', 6);
            obj.recorder.set('folder', folder);
            obj.recorder.setState('save_aveerr');
            obj.recorder.setState('save_test');
            DisplayManager.dispAll(obj.sim, obj.skip_disp);
            
            obj.trainingLoop();            
            obj.recordAveErr();
            ave_err = obj.ave_err;
            obj.saveTest();
            obj.recorder.saveAuto(obj.sim);
        end
    end
    
    methods
        function obj = FreqTest(varargin)
            obj.set_inner(varargin);
            obj.init();
            SimulationManager.set(obj.sim, 'N', obj.N, 'nsecs', obj.nsecs, 'dt', obj.dt);
            RNNManager.set(obj.sim.rnn, 'load_name', obj.load_rnn);
            RNNManager.setState(obj.sim.rnn, 'isPlastic', obj.isPlastic);
            FORCEManager.set(obj.sim.force, 'target_mode', obj.target_mode, 'freq', obj.freq, 'amp', obj.amp, 'load_wo_name', obj.load_wo, 'load_wf_name', obj.load_wf);
            SimulationManager.init(obj.sim);   
        end
        
        function obj = set(obj, varargin)
            obj.set_inner(varargin);
            obj.init();
        end
        
        function obj = set_inner(obj, argv)
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case {'N', 'n', 'nRec2Out'}
                        obj.N = argvdata{i};
                    case {'nsecs', 'simtime'}
                        obj.nsecs = argvdata{i};
                    case {'dt'}
                        obj.dt = argvdata{i};
                    case {'isPlastic'}
                        obj.isPlastic = argvdata{i};
                    case {'target_mode', 't_mode', 'tf'}
                        obj.target_mode = argvdata{i};
                    case {'freq', 'f'}
                        obj.freq = argvdata{i};
                    case {'amp', 'a'}
                        obj.amp = argvdata{i};
                    case {'mode'}
                        obj.mode = argvdata{i};
                    case {'sim_mode'}
                        obj.sim_mode = argvdata{i};
                    case {'rnn_mode'}
                        obj.rnn_mode = argvdata{i};
                    case {'force_mode'}
                        obj.force_mode = argvdata{i};
                    case {'sim'}
                        obj.sim = argvdata{i};
                    case {'load_rnn', 'load_net', 'l_net'}
                        obj.load_rnn = argvdata{i};
                    case {'load_wo', 'load_weight', 'l_wo'}
                        obj.load_wo = argvdata{i};
                    case {'load_wf', 'load_feedback', 'l_wf'}
                        obj.load_wf = argvdata{i};
                    otherwise
                        warning('FreqTest: Invalid Argument.');
                end
            end
            obj.setMode();
            setFlag(obj, 'uninitialize');
        end
    
        function obj = init(obj)
            if isempty(obj.recorder)
                obj.recorder = DataRecorder();
            end
            obj.setRecorderFlag();
            
            if isempty(obj.fig)
                obj.fig = FigureViewer();
            end
            obj.setFigureFlag();
            obj.fig.init();
            
            rnn = RNNProperties();
            force = FORCEProperties('rnn', rnn);
            
            obj.sim = SimulationProperties(...  %'N', obj.N, 'nsecs', obj.nsecs, 'dt', obj.dt, ...
               'rnn', rnn, 'force', force, 'viewer', obj.fig);
            SimulationManager.init(obj.sim);
            setFlag(obj, 'initialize');
            obj.sim_mode = obj.sim.mode;
        end
        
        function obj = setRecorderFlag(obj)
            if obj.skip_record
                if obj.skip_save
                    setFlag(obj.recorder, 'skip_both');
                else
                    setFlag(obj.recorder, 'skip_record');
                end
            elseif obj.skip_save
                setFlag(obj.recorder, 'skip_save');
            else
                setFlag(obj.recorder, '');
            end
        end
        
        function obj = setFigureFlag(obj)
            if obj.skip_figure
                setFlag(obj.fig, 'skip_figure');
            else
                setFlag(obj.fig, '');
            end
        end
            
        function obj = setState(obj, state, o)
            if nargin < 3
                o = true;
            end
            switch state
                case {'skip_record', 's_rec', 1}
                    b = 1;
                case {'skip_disp', 's_disp', 2}
                    b = 2;
                case {'skip_figure', 's_fig', 3}
                    b = 3;
                case {'skip_save', 's_save', 4}
                    b = 4;
                otherwise
                    return;
            end
            disp([state, num2str(b), num2str(obj.mode)]);
            obj.mode = bitset(obj.mode, b, o);
            obj.setMode();
        end
                    
        function obj = setMode(obj)
            obj.skip_record = bitget(obj.mode, 1);
            obj.skip_disp = bitget(obj.mode, 2);
            obj.skip_figure = bitget(obj.mode, 3);
            obj.skip_save = bitget(obj.mode, 4);
            obj.init();
        end        
            
        function obj = trainingLoop(obj)
            obj.fig.setFigure(1);
            SimulationManager.trainInit(obj.sim);
            for t = obj.sim.simtime
                if mod(t/round(obj.nsecs/8), 1)==0     
                    obj.fig.plotFigure(obj.sim, 1);
                end
                SimulationManager.trainOnce(obj.sim, t);
            end
            obj.fig.closeFigure(1);
            obj.fig.setFigure(2);
            obj.fig.plotFigure(obj.sim, 2);
        end
            
        function obj = recordAveErr(obj)
            obj.ave_err = SimulationManager.calcAveErr(obj.sim);
            DisplayManager.dispNum('average error', obj.ave_err);
        end
        
        function obj = saveTest(obj)
            if obj.skip_save
                return;
            end
            if obj.recorder.save_test
                filename = obj.recorder.saveName('test', 'sim');
                test = obj;
                save(filename, 'test');
            end
        end
    end
    
    
end