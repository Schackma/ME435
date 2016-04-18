function jointSliderChange(handles)
jointAngles(1) = round(get(handles.angle1, 'Value'));
jointAngles(2) = round(get(handles.angle2, 'Value'));
jointAngles(3) = round(get(handles.angle3, 'Value'));
jointAngles(4) = round(get(handles.angle4, 'Value'));
jointAngles(5) = round(get(handles.angle5, 'Value'));

jointAnglesStr = sprintf('%d %d %d %d %d',jointAngles);
set(handles.jointAngles_text,'string',jointAnglesStr); 
handles.user.jointAngles = jointAnglesStr;
initializeDhAxes(handles);