classdef FigureViewer < handle
    %FigureViewer is a discription of parameters for MATLAB graph.
    %
    
    properties
        linewidth;
        fontsize;
        fontweight;
        id = cell(1, 4); 
        
        mode = 0;
        while_training;
        after_training;
        after_testing;
        
        flag;
    end
    
    methods
        function FV = FigureViewer(varargin)
            if nargin > 0 && strcmp(varargin{1}, '-c')
                switch varargin{2}
                    case 'skip'
                        FV.set_inner(varargin(3:length(varargin)));
                        FV.setMode();
                        FV.init();
                        return;
                    otherwise
                end
            end
            FV = FV.defaultFigureViewer();
            FV.set_inner(varargin);
            FV.setMode();
            FV.init();
        end
        
        function FV = set(FV, varargin)
            FV.set_inner(varargin);
        end
        
        function FV = set_inner(FV, argv)
            argvnum = 0;
            if nargin > 0
                [argvstr, argvdata, argvnum] = argvSep(argv);
            end
            for i = 1:argvnum
                switch argvstr{i}
                    case {'linewidth', 'lw'}
                        FV.linewidth = argvdata{i};
                    case {'fontsize', 'fs'}
                        FV.fontsize = argvdata{i};
                    case {'fontweight', 'fw'}
                        FV.fontweight = argvdata{i};
                    case {'mode'}
                        FV.mode = argvdata{i};
                    case {'flag'}
                        setFlag(FV, argvdata{i});
                    otherwise
                        return;
                end
            end
        end
        
        function FV = init(FV)
            if checkFlag(FV, 'skip_figure')
                FV.mode = 0;
                FV.setMode();
            elseif checkFlag(FV, 'all')
                FV.setState('w_train');
                FV.setState('a_train');
                FV.setState('a_test');
                FV.setMode();
            end
        end
        
        
        
        function FV = setState(FV, state, o)
            if nargin < 3
                o = true;
            end
            switch state
                case {'while_training', 'w_train', 1}
                    b = 1;
                case {'after_training', 'a_train', 2}
                    b = 2;
                case {'after_testing', 'a_test', 3}
                    b = 3;
                otherwise
                    return;
            end
            FV.mode = bitset(FV.mode, b, o);
            FV.setMode();
        end
            
        function FV = setMode(FV)
           FV.while_training = bitget(FV.mode, 1);
           FV.after_training = bitget(FV.mode, 2);
           FV.after_testing = bitget(FV.mode, 3);
        end
        
        function FV = defaultFigureViewer(FV)
            if exist('default\fv.mat', 'file')
                load('default\fv.mat');
                FV = default_fv;
            else
                error('defaultFigureViewer: defualt_fv does not exist.');
            end
        end
        
        function FV = setFigure(FV, index)
            switch index
                case 1
                    if FV.while_training == false
                        return;
                    end
                    FV.id{index} = figure;
                case 2
                    if FV.after_training == false
                        return;
                    end
                    FV.id{index} = figure;
                case 3
                    if FV.after_testing == false
                        return;
                    end
                    FV.id{index} = figure;
                otherwise
                    return;
            end
        end
        
        function FV = plotFigure(FV, SP, index)
            if ~isempty(FV.id{index})
                figure(FV.id{index});
            else
                return;
            end
            switch index
                case 1
                    if FV.while_training == false
                        return;
                    end
                    FV.viewTraining(SP, SP.force, SP.record);
                case 2
                    if FV.after_training == false
                        return;
                    end
                    FV.viewTraining(SP, SP.force, SP.record);                    
                case 3
                    if FV.after_testing == false
                        return;
                    end
                    FV.viewTesting(SP, SP.force, SP.record);
                otherwise
                    return;
            end
        end
        
        function closeFigure(FV, index)
            if ~isempty(FV.id{index});
                close(FV.id{index});
            end
        end
                    
        
        function viewTraining(FV, SP, FP, FR)
            subplot('221');
            FV.viewOutput(SP, FP, FR);
            subplot('222');
            FV.viewWeightLength(SP, FR);
            subplot('223');
            FV.viewErr(SP, FR);
            subplot('224');
            FV.viewMatrixSize(SP, FR);
        end        
        
        function viewOutput(FV, SP, FP, FR)%, area)
%            subplot(area);
            plot(SP.simtime, FP.targetFunction, 'linewidth', FV.linewidth, 'color', 'green');
            hold on;
            plot(SP.simtime, FR.zt, 'linewidth', FV.linewidth, 'color', 'red');
            title('training', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            legend('f', 'z');
            xlabel('time', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            ylabel('f and z', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            axis tight; 
            hold off;
        end
        
        function viewWeightLength(FV, SP, FR)%, area)
%            subplot(area);
            plot(SP.simtime, FR.wo_len, 'linewidth', FV.linewidth);
            xlabel('time', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            ylabel('|w|','fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            legend('|w|');
            axis tight;
        end
        
        function viewMatrixSize(FV, SP, FR)%, area)
%            subplot(area);
            plot(SP.simtime, FR.M_tr, 'linewidth', FV.linewidth);
            xlabel('time', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            ylabel('|M|', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            legend('|M|');
            axis tight;
        end
        
        function viewDMSize(FV, SP, FR)%, area)
%            subplot(area);
            plot(SP.simtime, FR.dM_tr, 'linewidth', FV.linewidth);
            xlabel('time', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            ylabel('|dM|', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            legend('|dM|');
            axis tight;
        end
        
        function viewErr(FV, SP, FR)%, area)
%            subplot(area);
            plot(SP.simtime, FR.errt, 'linewidth', FV.linewidth);
            xlabel('time', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            ylabel('err', 'fontsize', FV.fontsize, 'fontweight', FV.fontweight);
            legend('err');
            axis tight;
        end
        
    end
end

