clc
clear

lipo2s = LiPoBattery(2);
fprintf('The voltage of lipo2s is %.1f volts\n', lipo2s.getVoltage())
for i = 1:4
    lipo2s.useBattery()
    fprintf('The voltage of lipo2s is %.1f volts\n', lipo2s.getVoltage())
end
fprintf('\n------\n');
lipo5s = LiPoBattery(5);
fprintf('The voltage of lipo5s is %.1f volts\n', lipo5s.getVoltage())
for i = 1:2
    for j = 1:2
        lipo5s.useBattery()
        fprintf('The voltage of lipo5s is %.1f volts\n', lipo5s.getVoltage())
    end
    lipo5s.chargeBattery()
    fprintf('The voltage of lipo5s is %.1f volts\n', lipo5s.getVoltage())
end
fprintf('\n------\n');
lipo1s = LiPoBattery(1);
fprintf('The voltage of lipo1s is %.1f volts\n', lipo1s.getVoltage())
for j = 1:3
    lipo1s.useBattery()
    fprintf('The voltage of lipo1s is %.1f volts\n', lipo1s.getVoltage())
end
lipo1s.chargeBattery()
lipo1s.chargeBattery()
fprintf('The voltage of lipo1s is %.1f volts\n', lipo1s.getVoltage())

% Expected output from this script:

% The voltage of lipo2s is 8.4 volts
% The voltage of lipo2s is 7.4 volts
% The voltage of lipo2s is 6.4 volts
% The voltage of lipo2s is 0.0 volts
% The voltage of lipo2s is 0.0 volts
% 
% ------
% The voltage of lipo5s is 21.0 volts
% The voltage of lipo5s is 18.5 volts
% The voltage of lipo5s is 16.0 volts
% The voltage of lipo5s is 21.0 volts
% The voltage of lipo5s is 18.5 volts
% The voltage of lipo5s is 16.0 volts
% The voltage of lipo5s is 21.0 volts
% 
% ------
% The voltage of lipo1s is 4.2 volts
% The voltage of lipo1s is 3.7 volts
% The voltage of lipo1s is 3.2 volts
% The voltage of lipo1s is 0.0 volts
% This battery is dead!
% This battery is dead!
% The voltage of lipo1s is 0.0 volts