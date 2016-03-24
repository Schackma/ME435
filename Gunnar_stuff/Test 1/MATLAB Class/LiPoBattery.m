classdef LiPoBattery < handle
    %LIPOBATTERY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nBatteries
        state
    end
    
    methods
        function obj = LiPoBattery(numBatteries)
            if(numBatteries < 0)
                fprintf('do not mess with me.  You get no batteries for trying that.\n');
                numBatteries = 0;
            elseif(numBatteries > 6)
                numBatteries = 6;
                fprintf('do not mess with me.  I will only give you 6 batteries\n');
            end
            obj.nBatteries = numBatteries;
            obj.state = 3;
        end
        
         function toReturn = getVoltage(obj)
             switch obj.state
                 case 3
                     toReturn = obj.nBatteries*4.2;
                 case 2
                     toReturn = obj.nBatteries*3.7;
                 case 1
                     toReturn = obj.nBatteries*3.2;
                 otherwise
                     toReturn = 0;
             end
         end
        
         function useBattery(obj)
             obj.state = obj.state - 1;
         end
         
         function chargeBattery(obj)
             if obj.state > 0
                 obj.state = 3;
             else
                 fprintf('This battery is dead!\n');
             end
         end
    end
end

