classdef RNNFinalizer < ObjectFinalizer
	properties
	end
	
	methods (Static)
		function savePotential(x, savedir, filename)
			save(strcat(savedir, filename), 'x');
		end
	
		function saveNetwork(M, savedir, filename)
			save(strcat(savedir, filename), 'M');
		end 
	end
end
