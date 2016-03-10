function varargout = gripper_popup(varargin)
% GRIPPER_POPUP MATLAB code for gripper_popup.fig
%      GRIPPER_POPUP, by itself, creates a new GRIPPER_POPUP or raises the existing
%      singleton*.
%
%      H = GRIPPER_POPUP returns the handle to a new GRIPPER_POPUP or the handle to
%      the existing singleton*.
%
%      GRIPPER_POPUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRIPPER_POPUP.M with the given input arguments.
%
%      GRIPPER_POPUP('Property','Value',...) creates a new GRIPPER_POPUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gripper_popup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gripper_popup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gripper_popup

% Last Modified by GUIDE v2.5 10-Mar-2016 16:12:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gripper_popup_OpeningFcn, ...
                   'gui_OutputFcn',  @gripper_popup_OutputFcn, ...
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


% --- Executes just before gripper_popup is made visible.
function gripper_popup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gripper_popup (see VARARGIN)

% Choose default command line output for gripper_popup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gripper_popup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gripper_popup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_button.
function open_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('open pressed\n');


% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('close pressed\n');
