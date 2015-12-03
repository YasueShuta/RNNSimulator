function [argvstr argvdata argvnum] = argvSep(argv)
    if mod(length(argv), 2) == 1
        error('argvSep: Invalid Argument.');
    end
    
    argvnum = length(argv)/2;

    argvstr = cell(1,argvnum);
    argvdata = cell(1,argvnum);
    
    for i = 1:argvnum
        arg = argv{2*i-1};
        if ischar(arg)
            argvstr{i} = arg;
            argvdata{i} = argv{2*i};
        else
            error('argvManager: Invalid Argument.');
        end
    end
end
