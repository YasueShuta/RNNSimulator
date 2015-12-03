classdef RNNInitializer < ObjectInitializer & RNNDefault
    properties
        n;     % number of neurons.
        p;     % percentage of connecting.
        g;     % g greater than 1 leads to chaotic networks.
        th;    % threshold of firing

        M0;
        x0;
        
        mode;  % Network Initialization Mode (0: Random Sparse)
        isPlastic = false;
        isLoadedNetwork = false;
        load_name;
        
        flag;
        option;
    end
    
    methods
        function obj = RNNInitializer(argv)
            if nargin == 0
                return;
            end
            obj.setDefault();
            obj.set_inner(argv);
        end
        
        function setDefault(obj)
            obj.n = obj.default_n;
            obj.p = obj.default_p;
            obj.g = obj.default_g;
            obj.th = obj.default_th;
        end
        
        function setMode(obj)
            obj.isPlastic = bitget(obj.mode, 1);
            if obj.isPlastic == true
				obj.setPlastic();
            elseif obj.isPlastic == false
				obj.resetPlastic();
            end
            obj.isLoadedNetwork = bitget(obj.mode, 2);
        end
        
        function set_inner(obj, argv)
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
                    case 'isPlastic'
                        obj.isPlastic = argvdata{i};
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
    end
    
    methods (Static)
    	function obj = init(varargin)
    		obj = RNN();
    		obj.set_inner(varargin);
    		obj.setMode();
    		obj.reset();
    	end
    	
        function obj = init6(n, p, g, th, M0, x0)
            obj = RNN();
            obj.setDefault();
            if ~isempty(n)
                obj.n = n;
            end
            if ~isempty(p)
                obj.p = p;
            end
            if ~isempty(g)
                obj.g = g;
            end
            if ~isempty(th)
                obj.th = th;
            end
            if isempty(M0)
                obj.M0 = RNNInitializer.initNetwork(obj.n, obj.p, obj.g);
            elseif size(M0, 1) ~= n || size(M0, 2) ~= n
                error('Invalid Argument(M0):');
            else
                obj.M0 = M0;
            end
            if isempty(x0)
                obj.x0 = RNNInitializer.initPotential(obj.n);
            elseif isempty(x0) || size(x0, 1) ~= n || size(x0, 2) ~= 1
                error('Invalid Argument(x0):');
            else
                obj.x0 = x0;
            end
            obj.reset();
        end
        
        function x = initPotential(n)
            x = 0.5*randn(n, 1);
        end
        
        function M = initNetwork(n, p, g)
            M = sprandn(n, n, p)*g/sqrt(n*p);
            M = full(M);
        end
        
        function copyRNNInitializer(obj, src)
            obj.n = src.n;
            obj.p = src.p;  
            obj.g = src.g; 
            obj.th = src.th;
            obj.M0 = src.M0;
            obj.x0 = src.x0;
        
            obj.mode = src.mode;  
            obj.isPlastic = src.isPlastic;
            obj.isLoadedNetwork = src.isLoadedNetwork;
            obj.load_name = src.load_name;
        
            obj.flag = src.flag;
            obj.option = src.option;
        end
    end
end