function swap( robot,plate1,plate2,openSpace,text )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

locations = [plate1,openSpace,plate2];

set(text,'String',robot.open);
for i = 0:5
    set(text,'String',robot.x(locations(mod(i,3)+1)));
    extend_retract(robot,mod(i,2)==0,text)
end
end

function extend_retract(robot,input,text)
set(text,'String',robot.extend);
    if input
        set(text,'String',robot.close);
    else
        set(text,'String',robot.open);
    end
set(text,'String',robot.retract);
end