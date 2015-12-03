classdef ObjectInitializer < MyObject
    %OBJECTINITIALIZER Interface for Initializer.
    %   Allocation rules, set parameter interface, e.t.c.
    
    properties
    end
    
    methods (Abstract)
        set_inner(obj, argv);
    end
    methods
        function obj = ObjectInitializer()
            return;
        end
    end
end

