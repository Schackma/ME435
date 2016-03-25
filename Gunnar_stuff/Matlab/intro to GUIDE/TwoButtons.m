function varargout = TwoButtons(varargin)
% TWOBUTTONS MATLAB code for TwoButtons.fig
%      TWOBUTTONS, by itself, creates a new TWOBUTTONS or raises the existing
%      singleton*.
%
%      H = TWOBUTTONS returns the handle to a new TWOBUTTONS or the handle to
%      the existing singleton*.
%
%      TWOBUTTONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOBUTTONS.M with the given input arguments.
%
%      TWOBUTTONS('Property','Value',...) creates a new TWOBUTTONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TwoButtons_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TwoButtons_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TwoButtons

% Last Modified by GUIDE v2.5 10-Mar-2016 12:13:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TwoButtons_OpeningFcn, ...
                   'gui_OutputFcn',  @TwoButtons_OutputFcn, ...
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


% --- Executes just before TwoButtons is made visible.
function TwoButtons_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TwoButtons (see VARARGIN)

% Choose default command line output for TwoButtons
handles.output = hObject;

% Update handles structure
%% PUT CODE YOU WANT TO RUN INITIALLY
clc;
handles.user.myData = 7;
guidata(hObject, handles);

% UIWAIT makes TwoButtons wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TwoButtons_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_left.
function pushbutton_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject, 'String','You just pressed me.  Creep.', 'BackgroundColor', 'y');
% set(handles.pushbutton_right, 'String','You just pressed me.  Creep.', 'BackgroundColor', 'k');
handles.user.myData = handles.user.myData + 10;
fprintf('Left: myData = %d\n',handles.user.myData);
guidata(hObject, handles);





% --- Executes on button press in pushbutton_right.
function pushbutton_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject, 'String','You just pressed me.  Creep.', 'BackgroundColor', 'r');
handles.user.myData = handles.user.myData - 11;
fprintf('Right: myData = %d\n',handles.user.myData);
guidata(hObject, handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_right.
function pushbutton_right_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
