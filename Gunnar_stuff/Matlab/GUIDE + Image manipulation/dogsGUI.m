function varargout = dogsGUI(varargin)
% DOGSGUI MATLAB code for dogsGUI.fig
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
%      applied to the GUI before dogsGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dogsGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dogsGUI

% Last Modified by GUIDE v2.5 15-Mar-2016 00:48:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dogsGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @dogsGUI_OutputFcn, ...
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


% --- Executes just before dogsGUI is made visible.
function dogsGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dogsGUI (see VARARGIN)

% Choose default command line output for dogsGUI
handles.output = hObject;
clc;
addImageToAxes('puppyKingsley.JPG',handles.axes_kingsley, 150);
addImageToAxes('Keely.JPG',handles.axes_keely, 150);
handles.user.moveAmount = 25;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dogsGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dogsGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_keelyLeft.
function pushbutton_keelyLeft_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keelyLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely,'Position',get(handles.axes_keely,'Position')+[-handles.user.moveAmount 0 0 0]);

% --- Executes on button press in pushbutton_keelyRight.
function pushbutton_keelyRight_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keelyRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely,'Position',get(handles.axes_keely,'Position')+[handles.user.moveAmount 0 0 0]);


% --- Executes on button press in pushbutton_keelyUp.
function pushbutton_keelyUp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keelyUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely,'Position',get(handles.axes_keely,'Position')+[0 handles.user.moveAmount 0 0]);


% --- Executes on button press in pushbutton_keelyDown.
function pushbutton_keelyDown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_keelyDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_keely,'Position',get(handles.axes_keely,'Position')+[0 -handles.user.moveAmount 0 0]);


% --- Executes on button press in pushbutton_kingsleyLeft.
function pushbutton_kingsleyLeft_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsleyLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley,'Position',get(handles.axes_kingsley,'Position')+[-handles.user.moveAmount 0 0 0]);


% --- Executes on button press in pushbutton_kingsleyRight.
function pushbutton_kingsleyRight_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsleyRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley,'Position',get(handles.axes_kingsley,'Position')+[handles.user.moveAmount 0 0 0]);


% --- Executes on button press in pushbutton_kingsleyUp.
function pushbutton_kingsleyUp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsleyUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley,'Position',get(handles.axes_kingsley,'Position')+[0 handles.user.moveAmount 0 0]);
    

% --- Executes on button press in pushbutton_kingsleyDown.
function pushbutton_kingsleyDown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kingsleyDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes_kingsley,'Position',get(handles.axes_kingsley,'Position')+[0 -handles.user.moveAmount 0 0]);


% --- Executes when selected object is changed in uipanel_kingsleyImage.
function uipanel_kingsleyImage_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_kingsleyImage 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.radiobutton_puppy,'Value'))
    addImageToAxes('puppyKingsley.JPG',handles.axes_kingsley, 150);
elseif(get(handles.radiobutton_baby,'Value'))
    addImageToAxes('babyKingsley.JPG',handles.axes_kingsley, 150);
else
    addImageToAxes('bigKingsley.JPG',handles.axes_kingsley, 150);
end


% --- Executes on button press in checkbox_kingsley.
function checkbox_kingsley_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_kingsley (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox_kingsley
if get(hObject,'Value') %make image visible
    set(get(handles.axes_kingsley,'Children'),'Visible','On');
    set(handles.uipanel_kingsleyMove,'Visible','On');
    set(handles.uipanel_kingsleyImage,'Visible','On');
else %make keely invisible
    set(get(handles.axes_kingsley,'Children'),'Visible','Off');
    set(handles.uipanel_kingsleyMove,'Visible','Off');
    set(handles.uipanel_kingsleyImage,'Visible','Off');
end


% --- Executes on button press in checkbox_keely.
function checkbox_keely_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_keely (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox_keely
if get(hObject,'Value') %make image visible
    set(get(handles.axes_keely,'Children'),'Visible','On');
    set(handles.uipanel_keelyMove,'Visible','On');
else %make keely invisible
    set(get(handles.axes_keely,'Children'),'Visible','Off');
    set(handles.uipanel_keelyMove,'Visible','Off');
end