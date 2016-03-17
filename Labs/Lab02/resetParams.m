function [handles] = resetParams( handles )
%ROBOTRESET Summary of this function goes here
%   Detailed explanation goes here


handles.user.extended = false;
handles.user.gripperOpen = false;
handles.user.position = 3;

set(handles.pushbutton_toggleZ,'String','Extend');
set(handles.pushbutton_toggleGrip,'String','Open');
set(handles.radiobutton_x3,'Value',1);


end

