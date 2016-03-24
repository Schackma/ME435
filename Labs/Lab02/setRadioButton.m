function [ ] = setRadioButton( handles )
%SETRADIOBUTTON Summary of this function goes here
%   Detailed explanation goes here

pos =handles.user.robot.xAxisPosition+1;
switch pos
    case 1
        set(handles.radiobutton_x1,'Value',1);
    case 2
        set(handles.radiobutton_x2,'Value',1);
    case 3
        set(handles.radiobutton_x3,'Value',1);
    case 4
        set(handles.radiobutton_x4,'Value',1);
    case 5
        set(handles.radiobutton_x5,'Value',1);
end


end

