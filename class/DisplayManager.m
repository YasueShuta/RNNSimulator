classdef DisplayManager
    properties (Constant)
        preline = 0;
        prespace = 5;
        postline = 0;
        postspace = 0;
    end
    
    methods (Static)
        function dispNum(str, num)
            disp([blanks(DisplayManager.prespace), str, ': ', num2str(num), blanks(DisplayManager.postspace)]);
        end
        
        function fDisp(fid, str, num)
            for i = 1:DisplayManager.prespace
                fprintf(fid, ' ');
            end
            fprintf(fid, '%s: %d\n', str, num);
        end
        
        function dispSim(SP, fid)
            if nargin == 1
                DisplayManager.dispNum('nRec2Out', SP.nRec2Out);
                DisplayManager.dispNum('nsecs', SP.nsecs);
                DisplayManager.dispNum('dt', SP.dt);
                DisplayManager.dispNum('mode', SP.mode);
            else                
                DisplayManager.fDisp(fid, 'nRec2Out', SP.nRec2Out);
                DisplayManager.fDisp(fid, 'nsecs', SP.nsecs);
                DisplayManager.fDisp(fid, 'dt', SP.dt);
                DisplayManager.fDisp(fid, 'mode', SP.mode);
            end
        end
                
        function dispRNN(RP, fid)
            if nargin == 1
                DisplayManager.dispNum('N', RP.n);
                DisplayManager.dispNum('p', RP.p);
                DisplayManager.dispNum('g', RP.g);
                DisplayManager.dispNum('mode', RP.mode);
            else                
                DisplayManager.fDisp(fid, 'N', RP.n);
                DisplayManager.fDisp(fid, 'p', RP.p);
                DisplayManager.fDisp(fid, 'g', RP.g);
                DisplayManager.fDisp(fid, 'mode', RP.mode);
            end
        end
        
        function dispFORCE(FP, fid)           
            if nargin == 1
                DisplayManager.dispNum('alpha', FP.alpha);
                DisplayManager.dispNum('learn_every', FP.learn_every);
                DisplayManager.dispNum('mode', FP.mode);
                DisplayManager.dispNum('freq', FP.freq);
                DisplayManager.dispNum('amp', FP.amp);
            else                
                DisplayManager.fDisp(fid, 'alpha', FP.alpha);
                DisplayManager.fDisp(fid, 'learn_every', FP.learn_every);
                DisplayManager.fDisp(fid, 'mode', FP.mode);
                DisplayManager.fDisp(fid, 'freq', FP.freq);
                DisplayManager.fDisp(fid, 'amp', FP.amp);
            end
        end 

        
        
        function dispAll(SP, flag)
            if nargin == 2 && flag == 1
                return;
            end
            disp('Simulation:');
            DisplayManager.dispSim(SP);
            disp('RNN Properties:');
            DisplayManager.dispRNN(SP.rnn);
            disp('FORCE Properties:');
            DisplayManager.dispFORCE(SP.force);
        end
    end
    
    
   
    methods
    end
end
