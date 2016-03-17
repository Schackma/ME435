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

<<<<<<< HEAD
% Last Modified by GUIDE v2.5 16-Mar-2016 20:55:54
=======
% Last Modified by GUIDE v2.5 16-Mar-2016 20:43:04
>>>>>>> 7728200bc0c8174f62602c88c949a47fc616f83a

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
handles.output = hObject;
handles.user.connected = false;
resetParams(handles);


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
set(handles.edit_response,'String',handles.user.robot.reset);
resetparams;


% —- Executes on button press in pushbutton_toggleZ.
function pushbutton_toggleZ_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toggleZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_response,'String',handles.user.robot,extend);




% —- Executes on button press in pushbutton_toggleGrip.
function pushbutton_toggleGrip_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toggleGrip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Matthew Schack, [16.03.16 20:55]
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


% —- Executes on button press in checkbox_connect.
function checkbox_connect_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_connect


<<<<<<< HEAD
% —- Executes when selected object is changed in uibuttongroup_xaxis.
=======
% --- Executes when selected object is changed in uibuttongroup_xaxis.
>>>>>>> 7728200bc0c8174f62602c88c949a47fc616f83a
function uibuttongroup_xaxis_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup_xaxis 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
<<<<<<< HEAD



function edit_moveFrom_Callback(hObject, eventdata, handles)
% hObject    handle to edit_moveFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_moveFrom as text
%        str2double(get(hObject,'String')) returns contents of edit_moveFrom as a double


% --- Executes during object creation, after setting all properties.
function edit_moveFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_moveFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_move.
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


% --- Executes during object creation, after setting all properties.
function edit_moveTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_moveTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
=======
>>>>>>> 7728200bc0c8174f62602c88c949a47fc616f83a
