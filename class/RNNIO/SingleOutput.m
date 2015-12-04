classdef SingleOutput < RNNIO
    %SINGLEOUTPUT このクラスの概要をここに記述
    %   詳細説明をここに記述
    properties
        Output;
    end
    methods
        function obj = SingleOutput()
            obj@RNNIO(1, 1);
            obj.reset();
        end
        
        function reset(obj)
            obj.Potential = 0;
            obj.update();
        end
        
        function len = length_out(obj)
            len = [];
        end
        
        function flow = outflow(obj)
            flow = [];
        end
        
        function update(obj)
            obj.Output = obj.Potential;
        end
    end
    
end

