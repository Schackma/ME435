function special_move( s,plate1,plate2,openSpace )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

locations = [plate1,plate2,openSpace];

% scriptCommand(s,sprintf('X-AXIS %d',plate1));
% extend_retract(s,'GRIPPER CLOSE');
% 
% scriptCommand(s,sprintf('X-AXIS %d',openSpace));
% extend_retract(s,'GRIPPER OPEN');
% 
% scriptCommand(s,sprintf('X-AXIS %d',plate2));
% extend_retract(s,'GRIPPER CLOSE');
% 
% scriptCommand(s,sprintf('X-AXIS %d',plate1));
% extend_retract(s,'GRIPPER OPEN');
% 
% scriptCommand(s,sprintf('X-AXIS %d',openSpace));
% extend_retract(s,'GRIPPER CLOSE');
% 
% scriptCommand(s,sprintf('X-AXIS %d',plate2));
% extend_retract(s,'GRIPPER OPEN');
scriptCommand(s,'GRIPPER OPEN');
for i = 0:5
    scriptCommand(s,sprintf('X-AXIS %d',locations(mod(i,3)+1)));
    if mod(i,2) == 0
        extend_retract(s,'GRIPPER CLOSE');
    else
        extend_retract(s,'GRIPPER OPEN');
    end
end
end

function extend_retract(s,input)
scriptCommand(s,'Z-AXIS EXTEND');
scriptCommand(s,input);
scriptCommand(s,'Z-AXIS RETRACT');
end