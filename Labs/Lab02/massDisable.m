function [ handles ] = massDisable( handles )
%MASSGREY Summary of this function goes here
%   Detailed explanation goes here

set(findobj('Style','pushbutton'),'Enable','off');
set(findobj('Style','radiobutton'),'Enable','off');
set(findobj('Style','edit'),'Enable','off');

set(handles.edit_comPort,'Enable','on');
set(handles.pushbutton_connect,'Enable','on');
set(handles.radiobutton_reality,'Enable','on');
set(handles.radiobutton_simulation,'Enable','on');




end

