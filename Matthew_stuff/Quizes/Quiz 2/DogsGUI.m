function varargout = DogsGUI(varargin)
% DOGSGUI MATLAB code for DogsGUI.fig
%      DOGSGUI, by itself, creates a new DOGSGUI or raises the existing
%      singleton*.
%
%      H = DOGSGUI returns the handle to a new DOGSGUI or the handle to
%      the existing singleton*.
%
%      DOGSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOGSGUI.M with the given input arguments.
%
%      DOGSGUI('Property','Value',...) creates a new DOGSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DogsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DogsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DogsGUI

% Last Modified by GUIDE v2.5 14-Mar-2016 22:29:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DogsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DogsGUI_OutputFcn, ...
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


% --- Executes just before DogsGUI is made visible.
function DogsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DogsGUI (see VARARGIN)

% Choose default command line output for DogsGUI
clc;
handles.output = hObject;

addImageToAxes('puppyKingsley.jpg',handles.axes_kingsley,150);
addImageToAxes('Keely.jpg',handles.axes_keely,150);
handles.user.moveAmount = 25;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DogsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DogsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_keely_left.
function pushbutton_keely_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keely_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely, 'Position', get(handles.axes_keely, 'Position')+[-handles.user.moveAmount 0 0 0])


% --- Executes on button press in pushbutton_keely_down.
function pushbutton_keely_down_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keely_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely, 'Position', get(handles.axes_keely, 'Position')+[0 -handles.user.moveAmount 0 0])

% --- Executes on button press in pushbutton_keely_up.
function pushbutton_keely_up_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keely_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely, 'Position', get(handles.axes_keely, 'Position')+[0 handles.user.moveAmount 0 0])

% --- Executes on button press in pushbutton_keely_right.
function pushbutton_keely_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keely_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely, 'Position', get(handles.axes_keely, 'Position')+[handles.user.moveAmount 0 0 0])

% --- Executes on button press in pushbutton_kingsley_left.
function pushbutton_kingsley_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsley_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley, 'Position', get(handles.axes_kingsley, 'Position')+[-handles.user.moveAmount 0 0 0])


% --- Executes on button press in pushbutton_kingsley_down.
function pushbutton_kingsley_down_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsley_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley, 'Position', get(handles.axes_kingsley, 'Position')+[0 -handles.user.moveAmount 0 0])


% --- Executes on button press in pushbutton_kingsley_up.
function pushbutton_kingsley_up_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsley_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley, 'Position', get(handles.axes_kingsley, 'Position')+[0 handles.user.moveAmount 0 0])


% --- Executes on button press in pushbutton_kingsley_right.
function pushbutton_kingsley_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsley_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley, 'Position', get(handles.axes_kingsley, 'Position')+[handles.user.moveAmount 0 0 0])


% --- Executes on button press in radiobutton_baby.
function radiobutton_baby_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_baby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_baby
addImageToAxes('babyKingsley.jpg',handles.axes_kingsley,150);


% --- Executes on button press in radiobutton_puppy.
function radiobutton_puppy_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_puppy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_puppy
addImageToAxes('puppyKingsley.jpg',handles.axes_kingsley,150);


% --- Executes on button press in radiobutton_big.
function radiobutton_big_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_big (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_big
addImageToAxes('bigKingsley.jpg',handles.axes_kingsley,150);

% --- Executes on button press in checkbox_kingsley.
function checkbox_kingsley_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_kingsley (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_kingsley
if get(hObject, 'Value')
    set(get(handles.axes_kingsley,'Children'),'Visible','on');
    set(handles.uipanel_kingsly_image, 'Visible','on');
    set(handles.uipanel_kingsleyMove, 'Visible','on');
else
     set(get(handles.axes_kingsley,'Children'),'Visible','off');
    set(handles.uipanel_kingsly_image, 'Visible','off');
    set(handles.uipanel_kingsleyMove, 'Visible','off');   
end


% --- Executes on button press in checkbox_keely.
function checkbox_keely_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_keely (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_keely
if get(hObject, 'Value')
    set(get(handles.axes_keely,'Children'),'Visible','on');
    set(handles.uipanel_keely_move, 'Visible','on');
else
    set(get(handles.axes_keely,'Children'),'Visible','off');
    set(handles.uipanel_keely_move, 'Visible','off');   
end