classdef Baby < handle
    %BANKACCOUNT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        time_since_feeding
    end
    
    methods
        function obj =  Baby(name)
            obj.name = name;
            obj.time_since_feeding = 0;
            fprintf('Hello baby, %s\n',name);
        end
        
        function feedBaby(obj)
            obj.time_since_feeding = 0; 
            fprintf('Thank you for feeding baby %s\n',obj.name);
        end
        
        function hourPasses(obj)
            obj.time_since_feeding  = obj.time_since_feeding + 1;
            switch obj.time_since_feeding
               case 1
                  fprintf('Baby %s is asleep\n',obj.name);
               case 2
                  fprintf('Baby %s is awake.  Time for food.\n',obj.name);
               otherwise
                  fprintf('Baby %s is CRYING uncontrollably!  Feed the Baby!\n',obj.name);
            end
        end
        
        function disp(obj)
            fprintf('Your baby is called %s.  Did you forget that...?',obj.name); 
        end
        
    end
    
end

