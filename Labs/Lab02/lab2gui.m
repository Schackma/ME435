% —- Executes on button press in pushbutton_toggleGrip.
function pushbutton_toggleGrip_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toggleGrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.user.gripperOpen)
    set(hObject,'String','Open');
    set(handles.text_status,'String',handles.user.robot.open);
else
    set(hObject,'String','Close');
    set(handles.text_status,'String',handles.user.robot.close);
end
handles.user.gripperOpen = ~handles.user.gripperOpen;
guidata(hObject,handles);

function edit_comPort_Callback(hObject, eventdata, handles)
% hObject    handle to edit_comPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_comPort as text
%        str2double(get(hObject,'String')) returns contents of edit_comPort as a double


% —- Executes during object creation, after setting all properties.
function edit_comPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_comPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% —- Executes on button press in pushbutton_connect.
function pushbutton_connect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_connect


if(~handles.user.connected)
    handles.user.robot = PlateLoaderSim(str2double(get(handles.edit_comPort,'String')));
    massEnable(handles);
    
else
    handles.user.robot.shutdown;
    massDisable(handles);
end
handles.user.connected = ~handles.user.connected;
guidata(hObject,handles);


function uibuttongroup_xaxis_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_xaxis 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_moveFrom_Callback(hObject, eventdata, handles)
% hObject    handle to edit_moveFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_moveFrom as text
%        str2double(get(hObject,'String')) returns contents of edit_moveFrom as a double


% —- Executes during object creation, after setting all properties.
function edit_moveFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_moveFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% —- Executes on button press in pushbutton_move.
function pushbutton_move_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_moveTo_Callback(hObject, eventdata, handles)
% hObject    handle to edit_moveTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_moveTo as text
%        str2double(get(hObject,'String')) returns contents of edit_moveTo as a double


% —- Executes during object creation, after setting all properties.
function edit_moveTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_moveTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_swap.
function pushbutton_swap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_swap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_spinFigure.
function pushbutton_spinFigure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spinFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_plate1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plate1 as text
%        str2double(get(hObject,'String')) returns contents of edit_plate1 as a double


% --- Executes during object creation, after setting all properties.
function edit_plate1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plate2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plate2 as text
%        str2double(get(hObject,'String')) returns contents of edit_plate2 as a double


% --- Executes during object creation, after setting all properties.
function edit_plate2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_empty_Callback(hObject, eventdata, handles)
% hObject    handle to edit_empty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_empty as text
%        str2double(get(hObject,'String')) returns contents of edit_empty as a double


% --- Executes during object creation, after setting all properties.
function edit_empty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_empty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_setTimeDelays.
function pushbutton_setTimeDelays_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setTimeDelays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_resetTimeDelays.
function pushbutton_resetTimeDelays_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_resetTimeDelays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_status.
function pushbutton_status_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
