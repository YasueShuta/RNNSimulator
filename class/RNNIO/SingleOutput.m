classdef SingleOutput < RNNIO
    %SINGLEOUTPUT ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
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

