classdef FORCEProperties_ < handle
    %FORCEProperties Properties of FORCE Learning.
    %   Ú×à–¾‚ð‚±‚±‚É‹Lq
    
    properties
        alpha;   % learning rate.
        r_alpha; % rate of alpha. alpha = r_alpha * n.
        learn_every;
        wo;
        dw;
        wf;
        
        mode;
        isTest = false;
        isLoadedWeight = false;
        isLoadedFeedback = false;
        target_mode = 0;

        load_wo_name;
        load_wf_name;
        
        freq;
        amp;
        targetFunction;
        targetFunction_forTest;
        
        linked_rnn;
        Output;
        z0;
        
        e;
        P;
        
        flag;
    end
    
    methods
        function FP = FORCEProperties(varargin)
            if nargin > 0 && strcmp(varargin{1}, '-c')
                switch varargin{2}
                    case 'skip'
                        FP = FORCEManager.set_inner(FP, varargin(3:length(varargin)));
                        return;
                    otherwise
                end
            end
            FP = FORCEManager.defaultFORCEProperties();
            FORCEManager.set_inner(FP, varargin);
        end
    end
end

