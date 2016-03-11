function varargout = Buttons(varargin)
% BUTTONS MATLAB code for Buttons.fig
%      BUTTONS, by itself, creates a new BUTTONS or raises the existing
%      singleton*.
%
%      H = BUTTONS returns the handle to a new BUTTONS or the handle to
%      the existing singleton*.
%
%      BUTTONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUTTONS.M with the given input arguments.
%
%      BUTTONS('Property','Value',...) creates a new BUTTONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Buttons_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Buttons_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Buttons

% Last Modified by GUIDE v2.5 10-Mar-2016 12:13:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Buttons_OpeningFcn, ...
                   'gui_OutputFcn',  @Buttons_OutputFcn, ...
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


% --- Executes just before Buttons is made visible.
function Buttons_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Buttons (see VARARGIN)

% Choose default command line output for Buttons
clc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Buttons wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Buttons_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushButtonTop.
function pushButtonTop_Callback(hObject, eventdata, handles)
% hObject    handle to pushButtonTop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'String','Look at you','BackgroundColor','red');
fprintf('you hit the top button\n')
handles.userData = handles.userData +10;
guidata(hObject,handles)


% --- Executes on button press in pushButtonBottom.
function pushButtonBottom_Callback(hObject, eventdata, handles)
% hObject    handle to pushButtonBottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'String','You crazy bastard','BackgroundColor','green');
fprintf('you hit the bottom button\n')


% --- Executes on key press with focus on pushButtonTop and none of its controls.
function pushButtonTop_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushButtonTop (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'String','oh, no')
