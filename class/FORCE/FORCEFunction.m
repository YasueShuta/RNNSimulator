classdef FORCEFunction < FORCEProperties
    methods
        function update(obj, ti)
            obj.updateError(ti);
            if mod(ti, obj.learn_every) == 0
                r = obj.connector.in.Readout;
                k = obj.P * r;
                rPr = r' * k;
                c = 1.0/(1.0 + rPr);
                obj.P = obj.P - k*(k'*c);
                dwt = -obj.error * k * c;
                obj.dw = dwt';
                obj.connector.weight = obj.connector.weight + obj.dw;
            end
        end
        
        function updateError(obj, ti)
            obj.error = obj.connector.out.Output - obj.target(ti);
        end    
    end
end