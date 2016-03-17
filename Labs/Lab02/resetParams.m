function [] = resetParams( handles )
%ROBOTRESET Summary of this function goes here
%   Detailed explanation goes here


handles.user.pushbutton_extended = false;
handles.user.pushbutton_gripperOpen = false;
handles.user.position = 3;

set(handles.toggleZ,'String','Extend');
set(handles.toggleGrip,'String','Open');
set(handles.radiobutton_x3,'Value',1);


end

