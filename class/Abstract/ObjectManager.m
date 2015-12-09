classdef ObjectManager < MyObject
    %OBJECTMANAGER Interface for Manager
    
    properties
    end
    
    methods (Static)
        function ret = findObjects(classname)
            if nargin == 0
                classname = 'ObjectManager';
            end
            list = evalin('base', 'whos');
            ret = {};
            j = 1;
            for i = 1:length(list)
                if strcmp(classname, list(i).class)
                    ret{j} = evalin('base', list(i).name);
                    j = j + 1;
                end
            end
        end     
    end
    
end

