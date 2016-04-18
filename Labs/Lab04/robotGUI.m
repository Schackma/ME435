function varargout = robotGUI(varargin)
% ROBOTGUI MATLAB code for robotGUI.fig
%      ROBOTGUI, by itself, creates a new ROBOTGUI or raises the existing
%      singleton*.
%
%      H = ROBOTGUI returns the handle to a new ROBOTGUI or the handle to
%      the existing singleton*.
%
%      ROBOTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOTGUI.M with the given input arguments.
%
%      ROBOTGUI('Property','Value',...) creates a new ROBOTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before robotGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to robotGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help robotGUI


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @robotGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @robotGUI_OutputFcn, ...
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


% --- Executes just before robotGUI is made visible.
function robotGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to robotGUI (see VARARGIN)

% Choose default command line output for robotGUI
handles.output = hObject;

% Update handles structure
jointSliderChange(handles);
handles.userData.connected = false;
set(handles.goto1_button,'Enable','off');
set(handles.goto2_button,'Enable','off');
set(handles.goto3_button,'Enable','off');
guidata(hObject, handles);

% UIWAIT makes robotGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = robotGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function COMPort_Callback(hObject, eventdata, handles)
% hObject    handle to COMPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COMPort as text
%        str2double(get(hObject,'String')) returns contents of COMPort as a double


% --- Executes during object creation, after setting all properties.
function COMPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COMPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% hObject    handle to openButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = serial(sprintf('COM%s',get(handles.COMPort,'String')),'BAUDRATE',9600);
fopen(s);
handles.userData.file = s;
set(handles.COMPort,'Enable','off');
handles.userData.connected = true;
guidata(hObject,handles);


% --- Executes on button press in closeButton.
function closeButton_Callback(hObject, eventdata, handles)
% hObject    handle to closeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.userData.file);
set(handles.COMPort,'Enable','on');
handles.userData.connected = false;
guidata(hObject,handles);


% --- Executes on slider movement.
function gripper_Callback(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('GRIPPER %d',get(hObject,'Value')));
end


% --- Executes during object creation, after setting all properties.
function gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle1_Callback(hObject, eventdata, handles)
% hObject    handle to angle1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(handles);
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.jointAngles, 'String')));
end


% --- Executes during object creation, after setting all properties.
function angle1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle2_Callback(hObject, eventdata, handles)
% hObject    handle to angle2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(handles);
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.jointAngles, 'String')));
end

% --- Executes during object creation, after setting all properties.
function angle2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle3_Callback(hObject, eventdata, handles)
% hObject    handle to angle3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(handles);
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.jointAngles, 'String')));
end


% --- Executes during object creation, after setting all properties.
function angle3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle4_Callback(hObject, eventdata, handles)
% hObject    handle to angle4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(handles);
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.jointAngles, 'String')));
end


% --- Executes during object creation, after setting all properties.
function angle4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle5_Callback(hObject, eventdata, handles)
% hObject    handle to angle5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
jointSliderChange(handles);
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.jointAngles, 'String')));
end


% --- Executes during object creation, after setting all properties.
function angle5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in set1_button.
function set1_button_Callback(hObject, eventdata, handles)
% hObject    handle to set1_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
savePosition(handles,handles.disp1_text);
set(handles.goto1_button,'Enable','on');

% --- Executes on button press in set2_button.
function set2_button_Callback(hObject, eventdata, handles)
% hObject    handle to set2_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
savePosition(handles,handles.disp2_text);
set(handles.goto2_button,'Enable','on');

% --- Executes on button press in set3_button.
function set3_button_Callback(hObject, eventdata, handles)
% hObject    handle to set3_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
savePosition(handles,handles.disp3_text);
set(handles.goto3_button,'Enable','on');

% --- Executes on button press in goto1_button.
function goto1_button_Callback(hObject, eventdata, handles)
% hObject    handle to goto1_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.disp1_text, 'String')));
end

% --- Executes on button press in goto2_button.
function goto2_button_Callback(hObject, eventdata, handles)
% hObject    handle to goto2_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.disp2_text, 'String')));
end

% --- Executes on button press in goto3_button.
function goto3_button_Callback(hObject, eventdata, handles)
% hObject    handle to goto3_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.userData.connected)
    s = handles.userData.file;
    fprintf(s,sprintf('POSITION %s',get(handles.disp3_text, 'String')));
end