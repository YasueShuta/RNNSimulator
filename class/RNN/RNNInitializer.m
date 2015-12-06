classdef RNNInitializer < ObjectInitializer & RNNDefault
    properties
        n;     % number of neurons.
        p;     % percentage of connecting.
        g;     % g greater than 1 leads to chaotic networks.
        th;    % threshold of firing

        M0;
        x0;
        
        mode = 0;  % Network Initialization Mode (0: Random Sparse)
        isPlastic = false;
        isLoadedNetwork = false;
        load_net;
        isLoadedPotential = false;
        load_x;
        
        flag;
        option;
    end
    
    methods
        function obj = RNNInitializer(varargin)
            if nargin == 0
                return;
            end
            obj.setDefault();
            obj.set_inner(varargin);
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
        
        function set_inner(obj, argvnum, argvstr, argvdata)
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
                    case {'load_net', 'l_net', 'ln'}
                        obj.load_net = argvdata{i};
                        if ~isempty(obj.load_net)
                            obj.isLoadedNetwork = true;
                        end
                    case {'load_x', 'l_x', 'lx'}
                    	obj.load_x = argvdata{i};
                    	if ~isempty(obj.load_x)
                    		obj.isLoadedPotential = true;
                    	end
                    otherwise
                        warning('RNNProperties: Invalid Argument.');
                end
            end
            obj.setNetwork();
            obj.setPotential();
        end
        
        function setNetwork(obj)           
        	if obj.isLoadedNetwork == false
                obj.M0 = obj.initNetwork(obj.n, obj.p, obj.g);
            else
            	obj.M0 = obj.loadNetwork(obj.load_net);
            	if isempty(obj.M0) || size(obj.M0, 1) ~= obj.n || size(obj.M0, 2) ~= obj.n
            		warning('Invalid Loading(M0):');
            		obj.M0 = obj.initNetwork(obj.n, obj.p, obj.g);
                end
            end                
        end
        
        function setPotential(obj)           
        	if obj.isLoadedPotential == false
                obj.x0 = obj.initPotential(obj.n);
            else
            	obj.x0 = obj.loadPotential(obj.load_x);
            	if isempty(obj.x0) || size(obj.x0, 1) ~= obj.n || size(obj.x0, 2) ~= 1
            		warning('Invalid Loading(x0):');
            		obj.x0 = obj.initPotential(obj.n);
            	end
            end
        end
    end
    
    methods (Static)
    	function obj = init(varargin)
    		obj = RNN();
            obj.setDefault();
    		obj.set(varargin);
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
                obj.M0 = obj.initNetwork(obj.n, obj.p, obj.g);
            elseif size(M0, 1) ~= n || size(M0, 2) ~= n
                error('Invalid Argument(M0):');
            else
                obj.M0 = M0;
            end
            if isempty(x0)
                obj.x0 = obj.initPotential(obj.n);
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
        
        function x = loadPotential(filename)
            if ~ischar(filename) || ~exist(filename, 'file')
                warning('Load Error: Potential File does not exist.');
                x = [];
                return;
            end
            tmp = load(filename, 'x');
            x = tmp{1};
        end
        
        function M = loadNetwork(filename)
            if ~ischar(filename) || ~exist(filename, 'file')
                warning('Load Error: Network File does not exist.');
                M = [];
                return;
            end
            tmp = load(filename, 'M');
            M = tmp{1};
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
            obj.load_net = src.load_net;
            obj.isLoadedPotential = src.isLoadedPotential;
            obj.load_x = src.load_x;
            
            obj.flag = src.flag;
            obj.option = src.option;
        end
    end
end