function updateSliders(handles,moveStr)
vals = str2num(moveStr);
set(handles.angle1, 'Value', vals(1));
set(handles.angle2, 'Value', vals(2));
set(handles.angle3, 'Value', vals(3));
set(handles.angle4, 'Value', vals(4));
set(handles.angle5, 'Value', vals(5));