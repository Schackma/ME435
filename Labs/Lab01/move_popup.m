function varargout = move_popup(varargin)
% MOVE_POPUP MATLAB code for move_popup.fig
%      MOVE_POPUP, by itself, creates a new MOVE_POPUP or raises the existing
%      singleton*.
%
%      H = MOVE_POPUP returns the handle to a new MOVE_POPUP or the handle to
%      the existing singleton*.
%
%      MOVE_POPUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVE_POPUP.M with the given input arguments.
%
%      MOVE_POPUP('Property','Value',...) creates a new MOVE_POPUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before move_popup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to move_popup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help move_popup

% Last Modified by GUIDE v2.5 10-Mar-2016 14:41:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @move_popup_OpeningFcn, ...
                   'gui_OutputFcn',  @move_popup_OutputFcn, ...
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


% --- Executes just before move_popup is made visible.
function move_popup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to move_popup (see VARARGIN)

% Choose default command line output for move_popup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes move_popup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = move_popup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pickup_location.
function pickup_location_Callback(hObject, eventdata, handles)
% hObject    handle to pickup_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pickup_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pickup_location
fprintf('pickup location changed to %d\n',get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function pickup_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pickup_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in drop_location.
function drop_location_Callback(hObject, eventdata, handles)
% hObject    handle to drop_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns drop_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from drop_location
fprintf('drop location changed to %d\n',get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function drop_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to drop_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in move_button.
function move_button_Callback(hObject, eventdata, handles)
% hObject    handle to move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pickup_loc = get(handles.pickup_location,'Value');
drop_loc = get(handles.drop_location,'Value');
fprintf('move from: %d.  move to: %d.\n',pickup_loc,drop_loc);
scriptCommand(get(move_popup,'UserData'),sprintf('MOVE %d %d',pickup_loc,drop_loc));