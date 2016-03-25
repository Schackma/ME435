function varargout = slider_testing(varargin)
% SLIDER_TESTING MATLAB code for slider_testing.fig
%      SLIDER_TESTING, by itself, creates a new SLIDER_TESTING or raises the existing
%      singleton*.
%
%      H = SLIDER_TESTING returns the handle to a new SLIDER_TESTING or the handle to
%      the existing singleton*.
%
%      SLIDER_TESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER_TESTING.M with the given input arguments.
%
%      SLIDER_TESTING('Property','Value',...) creates a new SLIDER_TESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slider_testing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slider_testing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slider_testing

% Last Modified by GUIDE v2.5 10-Mar-2016 12:34:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slider_testing_OpeningFcn, ...
                   'gui_OutputFcn',  @slider_testing_OutputFcn, ...
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


% --- Executes just before slider_testing is made visible.
function slider_testing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slider_testing (see VARARGIN)

% Choose default command line output for slider_testing
handles.output = hObject;

% Update handles structure
clc;
guidata(hObject, handles);

% UIWAIT makes slider_testing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slider_testing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
tmp = sprintf('%d',get(hObject,'Value'));
set(handles.slider_display, 'String', tmp);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
