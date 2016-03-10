function varargout = lab_1_gui(varargin)
% LAB_1_GUI MATLAB code for lab_1_gui.fig
%      LAB_1_GUI, by itself, creates a new LAB_1_GUI or raises the existing
%      singleton*.
%
%      H = LAB_1_GUI returns the handle to a new LAB_1_GUI or the handle to
%      the existing singleton*.
%
%      LAB_1_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB_1_GUI.M with the given input arguments.
%
%      LAB_1_GUI('Property','Value',...) creates a new LAB_1_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab_1_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab_1_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab_1_gui

% Last Modified by GUIDE v2.5 10-Mar-2016 13:18:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab_1_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @lab_1_gui_OutputFcn, ...
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


% --- Executes just before lab_1_gui is made visible.
function lab_1_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab_1_gui (see VARARGIN)

% Choose default command line output for lab_1_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab_1_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab_1_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('reset pushed\n');


% --- Executes on button press in x_axis_button.
function x_axis_button_Callback(hObject, eventdata, handles)
% hObject    handle to x_axis_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('x-axis pushed\n');
x_axis_popup;

% --- Executes on button press in z_axis_button.
function z_axis_button_Callback(hObject, eventdata, handles)
% hObject    handle to z_axis_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('z-axis pushed\n');
z_axis_popup;

% --- Executes on button press in gripper_button.
function gripper_button_Callback(hObject, eventdata, handles)
% hObject    handle to gripper_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('gripper pushed\n');

% --- Executes on button press in move_button.
function move_button_Callback(hObject, eventdata, handles)
% hObject    handle to move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('move pushed\n');

% --- Executes on button press in status_button.
function status_button_Callback(hObject, eventdata, handles)
% hObject    handle to status_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('status pushed\n');

% --- Executes on button press in special_move_button.
function special_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to special_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('special pushed\n');

% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)
% hObject    handle to exit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('exit pushed\n');
