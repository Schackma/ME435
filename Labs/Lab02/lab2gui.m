function varargout = lab2gui(varargin)
% LAB2GUI MATLAB code for lab2gui.fig
%      LAB2GUI, by itself, creates a new LAB2GUI or raises the existing
%      singleton*.
%
%      H = LAB2GUI returns the handle to a new LAB2GUI or the handle to
%      the existing singleton*.
%
%      LAB2GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB2GUI.M with the given input arguments.
%
%      LAB2GUI('Property','Value',...) creates a new LAB2GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab2gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab2gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab2gui

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab2gui_OpeningFcn, ...
                   'gui_OutputFcn',  @lab2gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% —- Executes just before lab2gui is made visible.
function lab2gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab2gui (see VARARGIN)

% Choose default command line output for lab2gui
clc
handles.output = hObject;
handles.user.connected = false;
handles = resetParams(handles);
handles = massDisable(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab2gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% —- Outputs from this function are returned to the command line.
function varargout = lab2gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% —- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String',handles.user.robot.reset);
handles = resetParams(handles);
drawImage(handles);
guidata(hObject,handles);


% —- Executes on button press in pushbutton_toggleZ.
function pushbutton_toggleZ_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toggleZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.user.extended)
    set(hObject,'String','Extend');
    set(handles.text_status,'String',handles.user.robot.retract);
else
    set(hObject,'String','Retract');
    set(handles.text_status,'String',handles.user.robot.extend);
end
handles.user.extended = ~handles.user.extended;
drawImage(handles);
guidata(hObject,handles);


% —- Executes on button press in pushbutton_toggleGrip.
function pushbutton_toggleGrip_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toggleGrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.user.gripperOpen)
    set(hObject,'String','Open');
    set(handles.text_status,'String',handles.user.robot.close);
else
    set(hObject,'String','Close');
    set(handles.text_status,'String',handles.user.robot.open);
end
handles.user.gripperOpen = ~handles.user.gripperOpen;
drawImage(handles);
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
    if all(ismember(get(handles.edit_comPort,'String'),'1234567890'))
        if get(handles.radiobutton_simulation,'Value') == 1
            handles.user.robot = PlateLoaderSim(str2double(get(handles.edit_comPort,'String')));
        else
            handles.user.robot = PlateLoader(str2double(get(handles.edit_comPort,'String')));
        end
        massEnable(handles);
        set(handles.uitable_delays,'Data',handles.user.robot.calTimeTable(:,2:4));
        set(hObject,'String','Disconnect');
        set(handles.edit_comPort,'BackgroundColor','w');
    else
        set(handles.edit_comPort,'BackgroundColor','r');
    end
    
else
    handles.user.robot.shutdown;
    massDisable(handles);
    set(hObject,'String','Connect');
end
handles.user.connected = ~handles.user.connected;
drawImage(handles);
guidata(hObject,handles);


function uibuttongroup_xaxis_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_xaxis 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String',handles.user.robot.x(str2double(get(hObject,'String'))));
drawImage(handles);

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


pos1 = floor(str2double(get(handles.edit_moveFrom,'String')));
pos2 = floor(str2double(get(handles.edit_moveTo,'String')));


if(pos1 >5)
    set(handles.edit_moveFrom,'BackgroundColor','r');
elseif(pos2>5)
    set(handles.edit_moveTo,'BackgroundColor','r');
else
    set(handles.edit_moveFrom,'BackgroundColor','w');
    set(handles.edit_moveTo,'BackgroundColor','w');
    set(handles.text_status,'String',handles.user.robot.movePlate(pos1,pos2));
end
drawImage(handles);
guidata(hObject,handles);

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

pos1 = floor(str2double(get(handles.edit_plate1,'String')));
pos2 = floor(str2double(get(handles.edit_plate2,'String')));
pos3 = floor(str2double(get(handles.edit_empty,'String')));

if pos1 == pos2
    set(handles.edit_plate1,'BackgroundColor','r');
    set(handles.edit_plate2,'BackgroundColor','r');
elseif pos1 == pos3
    set(handles.edit_plate1,'BackgroundColor','r');
    set(handles.edit_empty,'BackgroundColor','r');
elseif pos2 ==pos3
    set(handles.edit_plate2,'BackgroundColor','r');
    set(handles.edit_empty,'BackgroundColor','r');
elseif pos1 > 5
    set(handles.edit_plate1,'BackgroundColor','r');
elseif pos2 > 5
    set(handles.edit_plate2,'BackgroundColor','r');
elseif pos3 > 5
    set(handles.edit_empty,'BackgroundColor','r');
else
    set(handles.edit_plate1,'BackgroundColor','w');
    set(handles.edit_plate2,'BackgroundColor','w');
    set(handles.edit_empty,'BackgroundColor','w');
    swap(handles.user.robot,pos1,pos2,pos3,handles.text_status);
end
drawImage(handles);

% --- Executes on button press in pushbutton_spinFigure.
function pushbutton_spinFigure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spinFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta = 0; dTheta = 0.01;
img = getimage(handles.axes_display);
while(theta < 2*pi+0.02)
    theta = theta + dTheta 
    H = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1;]; %Rotation Mat    
    tform = affine2d(H);
    cla(handles.axes_display);
    image(imwarp(img,tform), 'Parent', handles.axes_display);
    drawnow;
end

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
zero = zeros(5,1);
time = [zero get(handles.uitable_delays,'Data') zero];
set(handles.text_status,'String',handles.user.robot.setTimeValues(time));



% --- Executes on button press in pushbutton_resetTimeDelays.
function pushbutton_resetTimeDelays_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_resetTimeDelays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String',handles.user.robot.resetDefaultTimes);
set(handles.uitable_delays, 'Data',handles.user.robot.defaultTimeTable(:,2:4));


% --- Executes on button press in pushbutton_status.
function pushbutton_status_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String',handles.user.robot.getStatus);


% --- Executes on button press in radiobutton_simulation.
function radiobutton_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_simulation


% --- Executes on button press in radiobutton_reality.
function radiobutton_reality_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_reality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton_reality

function [] = drawImage(handles)
% %handles.user.gripperOpen
gripperStatus = 1;
if(handles.user.robot.isPlatePresent)
    gripperStatus = 3;
elseif(~handles.user.robot.isGripperClosed)
    gripperStatus = 2;
end
handles.user.robot.xAxisPosition;
updateDisplay(handles.axes_display, handles.user.robot.plateLocations, ...
    handles.user.robot.isZAxisExtended, handles.user.robot.xAxisPosition, ...
    gripperStatus);


% --- Executes on mouse press over axes background.
function axes_display_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on mouse press over figure background.
function arm_gui_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to arm_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% switch eventdata.Key
%     case 'rightarrow'
%         if(handles.user.robot.xAxisPosition ~=5)
%             set(handles.text_status,'String',handles.user.robot.x(handles.user.robot.xAxisPosition+1));
%         end
%     case 'leftarrow'
%         if(handles.user.robot.xAxisPosition ~=1)
%             set(handles.text_status,'String',handles.user.robot.x(handles.user.robot.xAxisPosition-1));
%         end
%     case 'uparrow'
%         if(handles.user.extended)
%             set(handles.pushbutton_toggleZ,'String','Extend');
%             set(handles.text_status,'String',handles.user.robot.retract);
%             handles.user.extended = ~handles.user.extended;
%         end
%     case 'downarrow'
%         if(~handles.user.extended)
%         set(pushbutton_toggleZ,'String','Retract');
%         set(handles.text_status,'String',handles.user.robot.extend);
%         handles.user.extended = ~handles.user.extended;
%         end
%     otherwise
% end
% setRadioButton(handles);
% drawImage(handles);

