classdef DataRecorder < handle
    %SaveManager このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        parent;
        savedir;
        id;
        
        folder = 'testFile';
        currdir;
        datestr;
        
        file_count;
        figure_count;
        
        flag;
        mode = 0;
        save_test;
        save_net;
        save_wo;
        save_wf;
        save_fig1;
        save_fig2;
        save_aveerr;
        
        recordName;
    end
    
    methods
        function obj = set(DR, varargin)
            obj = DR;
            obj.set_inner(varargin);
        end
        
        function obj = set_inner(DR, argv)
            obj = DR;
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case 'folder'
                        obj.folder = argvdata{i};
                    case 'currdir'
                        obj.currdir = argvdata{i};
                    otherwise
                end
            end
            obj.setMode();
            obj.init();            
        end
        
        function obj = DataRecorder(d, varargin)
            if nargin == 0
                obj.currdir = pwd;
            else
                obj.currdir = d;
            end
            vec = datevec(date);
            obj.datestr = sprintf('%4d_%02d%02d', vec(1), vec(2), vec(3));
            
            obj.set_inner(varargin);
        end
        
        function obj = setState(obj, state, o)
            if nargin < 3
                o = true;
            end
            switch state
                case {'save_test', 's_test', 1}
                    b = 1;
                case {'save_net', 's_net', 2}
                    b = 2;
                case {'save_wo', 's_wo', 3}
                    b = 3;
                case {'save_wf', 's_wf', 4}
                    b = 4;
                case {'save_fig1', 's_fig1', 5}
                    b = 5;
                case {'save_fig2', 's_fig2', 6}
                    b = 6;
                case {'save_aveerr', 's_aveerr', 7}
                    b = 7;
                otherwise
                    return;
            end
            obj.mode = bitset(obj.mode, b, o);
            obj.setMode();
        end
        
        function obj = setMode(obj)
            obj.save_test = bitget(obj.mode, 1);
            obj.save_net = bitget(obj.mode, 2);
            obj.save_wo = bitget(obj.mode, 3);
            obj.save_wf = bitget(obj.mode, 4);
            obj.save_fig1 = bitget(obj.mode, 5);
            obj.save_fig2 = bitget(obj.mode, 6);
            obj.save_aveerr = bitget(obj.mode, 7);
        end 
        
        function obj = init(DR)
            obj = DR;
            
            obj.parent = strcat(DR.currdir, '\', DR.folder);            
            obj.savedir = strcat(DR.parent, '\', DR.datestr);
            
            obj.file_count = 0;
            obj.figure_count = 0;
            if ~exist(obj.savedir, 'dir')
                mkdir(obj.savedir);
                mkdir(strcat(obj.savedir, '\data'));
                mkdir(strcat(obj.savedir, '\sim'));
                mkdir(strcat(obj.savedir, '\figure'));
                mkdir(strcat(obj.savedir, '\sample'));
            end
            if ~exist(strcat(obj.savedir, '\idCount.mat'), 'file')
                obj.id = 0;
            else
                obj.id = importdata(strcat(obj.savedir, '\idCount.mat')) + 1;
            end
            obj.saveId();
            
            obj.recordName = strcat(obj.savedir, '\data\record', num2str(obj.id, '%04d'), '.txt');
            obj.resetRecord();
        end
        
        function obj = resetId(obj, id)
            if nargin == 1
                id = -1;
            end
            obj.id = id;
            obj.saveId();
            obj.init();
        end
        
        function saveId(obj)
            id_count = obj.id;
            save(strcat(obj.savedir, '\idCount.mat'), 'id_count');
        end
        
        
        function save(obj, data, name, dir)
            if nargin == 4
                filename = obj.saveName(name, dir);
            elseif nargin == 3
                filename = obj.saveName(name);
            else
                filename = obj.saveName();
            end
            save(filename, 'data');
        end
        
        function str = saveName(obj, name, dir)
            if nargin == 3
                str = strcat(obj.savedir, '\', dir, '\', name, sprintf('%04d.mat', obj.id));
            elseif nargin == 2
                str = strcat(obj.savedir, '\data\', name, sprintf('%04d.mat', obj.id));
            else
                str = strcat(obj.savedir, '\data\', sprintf('data%04d_%02d.mat', obj.id, obj.file_count));
                obj.file_count = obj.file_count + 1;
            end
        end
        
        function str = loadName(obj, name, dir)
            if nargin == 2
                dir_ = '\data\';
            else
                dir_ = strcat('\', dir, '\');
            end
            str = strcat(obj.savedir, dir_, name);
        end
        
        
        function saveAuto(obj, SP)
           if checkFlag(obj, 'skip_save') || checkFlag(obj, 'skip_both')
               return;
           end
           if obj.save_net
               obj.saveNetworkMatrix(SP.rnn);              
           end
           if obj.save_wo
               obj.saveForceWeight(SP.force);
           end
           if obj.save_wf
               obj.saveForceFeedback(SP.force);
           end
           if obj.save_fig1 && SP.viewer.after_training
               obj.saveFigure(SP.viewer.id{2});
           end
           if obj.save_fig2 && SP.viewer.after_testing
               obj.saveFigure(SP.viewer.id{3});               
           end
           if obj.save_aveerr
               obj.saveAveErr(SP.record);
           end
        end
           
        function saveFigure(obj, fig)
            if nargin == 1
                fig = gcf;
            end
            filename = strcat(obj.savedir, '\figure\', sprintf('%04d_%02d', obj.id, obj.figure_count));
            saveas(fig, strcat(filename, '.mat'));
            saveas(fig, strcat(filename, '.emf'));
            obj.figure_count = obj.figure_count + 1;
        end
        
        function saveNetworkMatrix(obj, RP)
            filename = obj.saveName('net', 'data');
            RNNManager.saveNetwork(RP, filename); 
        end
        
        function saveForceWeight(obj, FP)
            filename = obj.saveName('force_wo', 'data');
            FORCEManager.saveWeight(FP, filename);
        end
        
        function saveForceFeedback(obj, FP)
            filename = obj.saveName('force_wf', 'data');
            FORCEManager.saveFeedback(FP, filename);
        end
        
        function saveAveErr(obj, FR)
            filename = obj.saveName('aveerr', 'data');
            ave_err = FR.ave_err;
            save(filename, 'ave_err');
        end
        
        function resetRecord(obj)
            if checkFlag(obj, 'skip_record') || checkFlag(obj, 'skip_both')
                return;
            end
            fid = fopen(obj.recordName, 'w');    
            fprintf(fid, '%s_%04d\n', obj.datestr, obj.id);
            fclose(fid);
        end
        
        function recordParameter(obj, SP)
            if checkFlag(obj, 'skip_record') || checkFlag(obj, 'skip_both')
                return;
            end
            fid = fopen(obj.recordName, 'a');
            fprintf(fid, '\nSimulation:\n');
            DisplayManager.dispSim(SP, fid);
            fprintf(fid,  '\nRNN Properties:\n');
            DisplayManager.dispRNN(SP.rnn, fid);
            fprintf(fid, '\nFORCE Properties:\n');
            DisplayManager.dispFORCE(SP.force, fid);
            fprintf(fid, '\n');
            fclose(fid);
        end
        
        function recordAveErr(obj, SP)
            if checkFlag(obj, 'skip_record') || checkFlag(obj, 'skip_both')
                return;
            end
            fid = fopen(obj.recordName, 'a');
            fprintf(fid, '\nAverage Error: %f\n', SP.record.ave_err);
            fclose(fid);
        end
    end
        
            
end

