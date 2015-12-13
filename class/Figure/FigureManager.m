classdef FigureManager < ObjectManager & ObjectInitializer
	properties
		linewidth;
		fontsize;
		fontweight;
		id = {};
		nextId = 0;
		
		flag='';
		colorSet;
		colorSetNum;
    end
	
	methods
		function obj = FigureManager(varargin)
			obj.set(varargin);
		end
		
		function set_inner(obj, argvnum, argvstr, argvdata)
			obj.setDefault();
			if nargin < 2 || argvnum == 0
			else
				for i = 1:argvnum
					switch argvstr{i}
						case {'linewidth', 'width', 'lw'}
							obj.linewidth = argvdata{i};
						case {'fontsize', 'size', 'fs'}
							obj.fontsize = argvdata{i};
						case {'fontweight', 'weight', 'fw'}
							obj.fontweight = argvdata{i};
						case {'colorSet', 'colors'}
							obj.colorSet = argvdata{i};
						case {'flag'}
							obj.flag = argvdata{i};
						otherwise
					end
				end
			end
			obj.reset();
		end
		
		function reset(obj)
			if obj.nextId == 0
				obj.nextId = 1;
			end
			obj.colorSetNum = length(obj.colorSet);
		end
		
		function setDefault(obj)
			obj.linewidth = FigureDefault.linewidth;
			obj.fontsize = FigureDefault.fontsize;
			obj.fontweight = FigureDefault.fontweight;
			obj.colorSet = FigureDefault.colorSet;
		end
	end

	methods (Static)
		function ret = getObject(tmp)
			if nargin == 0
				tmp = RecordManager.findObjects('FigureManager');
			end
			if isempty(tmp)
				evalin('base', 'figureManager_ = FigureManager();');
				ret = evalin('base', 'figureManager_');
				return;
			end
			ret = tmp{1};
		end
		
		function id = getId(FV)
			FM = FigureManager.getObject();
			id = FM.nextId;
			FM.id{id} = FV;
			FM.nextId = FM.nextId + 1;
		end
	end
end
