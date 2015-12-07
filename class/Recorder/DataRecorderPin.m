classdef DataRecorderPin < handle
    properties
        data;
        
        %{
        test;
        net;
        wo;
        wf;
        fig1;
        fig2;
        aveerr;
        %}
    end
    methods
        function obj = DataRecorderPin(mode)
            obj.data = mode;
            obj.set(mode);
        end
        function set(obj, mode)
        end
        function pinChange(obj, s, b)
        end
    end
end