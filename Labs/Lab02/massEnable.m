function [ handles ] = massEnable( handles )
%MASSENABLE Summary of this function goes here
%   Detailed explanation goes here

set(findobj('Style','pushbutton'),'Enable','on');
set(findobj('Style','radiobutton'),'Enable','on');
set(findobj('Style','edit'),'Enable','on');

set(handles.edit_comPort,'Enable','off');
set(handles.radiobutton_reality,'Enable','off');
set(handles.radiobutton_simulation,'Enable','off');


end

