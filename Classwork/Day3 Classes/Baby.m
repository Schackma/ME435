classdef Baby < handle
    %BABY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        hunger
    end
    
    methods
        function obj= Baby(name)
            obj.name = name;
            obj.hunger = 0;
            fprintf('hello baby %s',name);
        end
        
        function hourPasses(obj)
            obj.hunger=obj.hunger+1;
            if(obj.hunger == 1)
                fprintf('Baby %s is sleeping quietly.\n',obj.name);
            elseif(obj.hunger == 2)
                fprintf('Baby is awake. Time to feed %s\n',obj.name);
            else
                fprintf('Baby %s is crying uncontrollingly!  Feed the baby\n',obj.name);
            end
        end
        
        function feedBaby(obj)
            obj.hunger = 0;
            fprintf('Thank you for feeding the baby\n');
        end
    end
    
end

