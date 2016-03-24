function varargout = Binary_Calculator(varargin)
% BINARY_CALCULATOR MATLAB code for Binary_Calculator.fig
%      BINARY_CALCULATOR, by itself, creates a new BINARY_CALCULATOR or raises the existing
%      singleton*.
%
%      H = BINARY_CALCULATOR returns the handle to a new BINARY_CALCULATOR or the handle to
%      the existing singleton*.
%
%      BINARY_CALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BINARY_CALCULATOR.M with the given input arguments.
%
%      BINARY_CALCULATOR('Property','Value',...) creates a new BINARY_CALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Binary_Calculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Binary_Calculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Binary_Calculator

% Last Modified by GUIDE v2.5 22-Mar-2016 12:24:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Binary_Calculator_OpeningFcn, ...
                   'gui_OutputFcn',  @Binary_Calculator_OutputFcn, ...
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


% --- Executes just before Binary_Calculator is made visible.
function Binary_Calculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Binary_Calculator (see VARARGIN)

% Choose default command line output for Binary_Calculator
handles.output = hObject;

% Update handles structure
handles.user.curString = '0';
guidata(hObject, handles);

% UIWAIT makes Binary_Calculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Binary_Calculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_0.
function pushbutton_0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.user.curString == '0')
   return; 
end

handles.user.curString = strcat(handles.user.curString, '0');
updateText(hObject, handles);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_1.
function pushbutton_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.user.curString == '0')
   handles.user.curString = '1'; 
   updateText(hObject, handles);
   return;
end
handles.user.curString = strcat(handles.user.curString, '1');
updateText(hObject, handles);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.user.curString = '0';
updateText(hObject, handles);
guidata(hObject, handles);


function updateText(hObject, handles)
%do the thing
handles.text_binary.String = handles.user.curString;
handles.text_decimal.String = bin2dec(handles.user.curString);
guidata(hObject, handles);
