#include "ObjectInitializer.h"
#include <iostream>
#include <string>
#include <sstream>

ObjectInitializer::ObjectInitializer() {

}

ObjectInitializer::~ObjectInitializer() {

}

int ObjectInitializer::set(std::string argv) {
	if (argv.length() == 0) {
		set_inner();
		return 0;
	}

	std::vector<std::string> vec;
	std::stringstream ss(argv);
	char sep = ' ';
	std::string buf;

	while (std::getline(ss, buf, sep)){
		vec.push_back(buf);
	}
	return set(vec);
}

int ObjectInitializer::set(std::vector<std::string> argv) {
	if (argv.size() == 0){
		return set_inner();
	}

	if (argv.size()	% 2 == 1) {
		std::cout << "Invalid Argument (Initializer):" << std::endl;
		return 0;
	}
	else {
		int argvnum;
		std::string buf;

		argvnum = argv.size() / 2;

		std::vector<std::string> argvstr (argvnum);
		std::vector<std::string> argvdata (argvnum);

		for (int i = 0; i < argvnum; i++) {
			buf = argv.at(2 * i);
			if (buf.at(0) == '-') buf = buf.erase(0, 1);
			argvstr[i]+= buf;
			argvdata[i]+= argv.at(2 * i + 1);
		}
		return set_inner(argvnum, argvstr, argvdata);
	}
}


/*
classdef ObjectInitializer < MyObject
    %OBJECTINITIALIZER Interface for Initializer.
    %   Allocation rules, set parameter interface, e.t.c.
    
    properties
    end
    
    methods (Abstract)
        set_inner(obj, argvnum, argvstr, argvdata);
    end
    methods
    	function set(obj, varargin)
    		if nargin < 2
                obj.set_inner(0);
                return;
            elseif iscell(varargin{1})
                if isempty(varargin{1})
                    obj.set_inner(0);
                    return;
                end
    			[argvstr, argvdata, argvnum] = argvSep(varargin{1});
            else
                [argvstr, argvdata, argvnum] = argvSep(varargin);
            end
            obj.set_inner(argvnum, argvstr, argvdata);
    	end
    end
end

*/