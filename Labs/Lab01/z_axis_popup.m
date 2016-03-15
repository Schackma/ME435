function varargout = z_axis_popup(varargin)
% Z_AXIS_POPUP MATLAB code for z_axis_popup.fig
%      Z_AXIS_POPUP, by itself, creates a new Z_AXIS_POPUP or raises the existing
%      singleton*.
%
%      H = Z_AXIS_POPUP returns the handle to a new Z_AXIS_POPUP or the handle to
%      the existing singleton*.
%
%      Z_AXIS_POPUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Z_AXIS_POPUP.M with the given input arguments.
%
%      Z_AXIS_POPUP('Property','Value',...) creates a new Z_AXIS_POPUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before z_axis_popup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to z_axis_popup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help z_axis_popup

% Last Modified by GUIDE v2.5 10-Mar-2016 13:44:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @z_axis_popup_OpeningFcn, ...
                   'gui_OutputFcn',  @z_axis_popup_OutputFcn, ...
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


% --- Executes just before z_axis_popup is made visible.
function z_axis_popup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to z_axis_popup (see VARARGIN)

% Choose default command line output for z_axis_popup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes z_axis_popup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = z_axis_popup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in extend_button.
function extend_button_Callback(hObject, eventdata, handles)
% hObject    handle to extend_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('extend button pushed\n');
scriptCommand(get(z_axis_popup,'UserData'),sprintf('Z-AXIS EXTEND'));


% --- Executes on button press in retract_button.
function retract_button_Callback(hObject, eventdata, handles)
% hObject    handle to retract_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('retract button pushed\n');
scriptCommand(get(z_axis_popup,'UserData'),sprintf('Z-AXIS RETRACT'));
