function varargout = special_move_popup(varargin)
% SPECIAL_MOVE_POPUP MATLAB code for special_move_popup.fig
%      SPECIAL_MOVE_POPUP, by itself, creates a new SPECIAL_MOVE_POPUP or raises the existing
%      singleton*.
%
%      H = SPECIAL_MOVE_POPUP returns the handle to a new SPECIAL_MOVE_POPUP or the handle to
%      the existing singleton*.
%
%      SPECIAL_MOVE_POPUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECIAL_MOVE_POPUP.M with the given input arguments.
%
%      SPECIAL_MOVE_POPUP('Property','Value',...) creates a new SPECIAL_MOVE_POPUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before special_move_popup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to special_move_popup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help special_move_popup

% Last Modified by GUIDE v2.5 10-Mar-2016 16:27:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @special_move_popup_OpeningFcn, ...
                   'gui_OutputFcn',  @special_move_popup_OutputFcn, ...
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


% --- Executes just before special_move_popup is made visible.
function special_move_popup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to special_move_popup (see VARARGIN)

% Choose default command line output for special_move_popup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes special_move_popup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = special_move_popup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in tray_1_loc.
function tray_1_loc_Callback(hObject, eventdata, handles)
% hObject    handle to tray_1_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tray_1_loc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tray_1_loc
fprintf('tray 1 location changed to %d\n',get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function tray_1_loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tray_1_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in tray_2_loc.
function tray_2_loc_Callback(hObject, eventdata, handles)
% hObject    handle to tray_2_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tray_2_loc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tray_2_loc
fprintf('tray 2 location changed to %d\n',get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function tray_2_loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tray_2_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in empty_space_loc.
function empty_space_loc_Callback(hObject, eventdata, handles)
% hObject    handle to empty_space_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns empty_space_loc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from empty_space_loc
fprintf('empty space location changed to %d\n',get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function empty_space_loc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to empty_space_loc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in special_move_button.
function special_move_button_Callback(hObject, eventdata, handles)
% hObject    handle to special_move_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tray_1_loc = get(handles.tray_1_loc,'Value');
tray_2_loc = get(handles.tray_2_loc,'Value');
empty_loc = get(handles.empty_space_loc,'Value');
if(tray_1_loc == tray_2_loc || tray_1_loc == empty_loc || empty_loc == tray_2_loc)
    fprintf('ERROR:  PLEASE MAKE SURE ALL 3 POSITIONS ARE DIFFERENT\n');
    return;
end
fprintf('special move (%d,%d,%d)\n',tray_1_loc,tray_2_loc,empty_loc);
special_move(get(special_move_popup,'UserData'),tray_1_loc,tray_2_loc,empty_loc);

