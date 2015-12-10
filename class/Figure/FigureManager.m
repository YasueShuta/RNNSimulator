classdef FigureManager < ObjectManager
	properties
		linewidth;
		fontsize;
		fontweight;
		id;
	end

	methods (Static)
		function ret = getObject(tmp)
			if nargin == 0
				tmp = RecordManager.findObjects('FigureManager');
			end
			if isemppty(tmp)
				ret = [];
				return;
			end
			ret = tmp{1};
		end
	end
end
