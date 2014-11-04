function varargout = SeimoSignal(varargin)
% SEIMOSIGNAL MATLAB code for SeimoSignal.fig
%      SEIMOSIGNAL, by itself, creates a new SEIMOSIGNAL or raises the existing
%      singleton*.
%
%      H = SEIMOSIGNAL returns the handle to a new SEIMOSIGNAL or the handle to
%      the existing singleton*.
%
%      SEIMOSIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEIMOSIGNAL.M with the given input arguments.
%
%      SEIMOSIGNAL('Property','Value',...) creates a new SEIMOSIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SeimoSignal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SeimoSignal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SeimoSignal

% Last Modified by GUIDE v2.5 24-Oct-2013 09:16:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SeimoSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @SeimoSignal_OutputFcn, ...
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


% --- Executes just before SeimoSignal is made visible.
function SeimoSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SeimoSignal (see VARARGIN)

% Choose default command line output for SeimoSignal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

delete data/data_temp.mat
load data/data

y_data=data(:,1);
time_inc=time;
x_data=(1:length(y_data))*time_inc;
v_data=cumsum(y_data*time_inc)*9.8e3;
s_data=cumsum(v_data*time_inc);
save data/data_temp x_data y_data v_data s_data time_inc
set(handles.T_Tr1,'String',num2str(x_data(1)));
set(handles.T_Tr2,'String',num2str(x_data(end)));


% UIWAIT makes SeimoSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SeimoSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Menu_File_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('DataFromLMS/*.mat');
[time,data,Sv,text]=LoadData([pathname,filename]);
save data/data data time Sv text
set(handles.P_datatype,'string',text);
set(handles.T_Tr1,'String',num2str(Sv));
set(handles.T_Tr2,'String',num2str(time*length(data)));
set(handles.T_Filename,'string',filename);


function Time_increment_Callback(hObject, eventdata, handles)
% hObject    handle to Time_increment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_increment as text
%        str2double(get(hObject,'String')) returns contents of Time_increment as a double


% --- Executes during object creation, after setting all properties.
function Time_increment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_increment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Scale_Callback(hObject, eventdata, handles)
% hObject    handle to T_Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Scale as text
%        str2double(get(hObject,'String')) returns contents of T_Scale as a double


% --- Executes during object creation, after setting all properties.
function T_Scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_load.
function B_load_Callback(hObject, eventdata, handles)
% hObject    handle to B_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_load
load data/data
P_opt=get(handles.P_datatype,'value');
%time_inc=str2double(get(handles.Time_increment,'string'));
time_inc=time;
tr1=fix(str2double(get(handles.T_Tr1,'string'))/time_inc);
tr2=fix(str2double(get(handles.T_Tr2,'string'))/time_inc);
if tr1<=0
    tr1=1;
end
if tr2>=length(data)
    tr2=length(data);
end
scale=str2double(get(handles.T_Scale,'string'));

tempy=data(:,P_opt)*scale;
y_data=tempy(tr1:tr2);
tempx=(1:length(data))*time_inc;
x_data=tempx(tr1:tr2);

v_data=cumsum(y_data*time_inc)*9.8e3;
s_data=cumsum(v_data*time_inc);
save data/data_temp x_data y_data v_data s_data time_inc
save data/data_fil x_data y_data v_data s_data time_inc

if P_opt==8 || P_opt==9
    axes(handles.axes3);
    plot(x_data,y_data)
    ylabel('Displacement / mm')
    xlabel('Time /s')
    grid on
    axes(handles.axes2);
    cla
    axes(handles.axes1);
    cla
else
    axes(handles.axes1);
    plot(x_data,y_data)
    ylabel('Acceleration /g')
    xlabel('Time /s')
    grid on
    
    axes(handles.axes2);
    plot(x_data,v_data)
    ylabel('Velocity / mm/s')
    xlabel('Time /s')
    grid on
    
    axes(handles.axes3);
    plot(x_data,s_data)
    ylabel('Displacement / mm')
    xlabel('Time /s')
    grid on
end


% --- Executes on button press in B_Fresh.
function B_Fresh_Callback(hObject, eventdata, handles)
% hObject    handle to B_Fresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_Fresh
load data/data_temp

order=str2double(get(handles.T_Filter_Order,'string'));
%Wn=[str2double(get(handles.T_Freq1,'string')),str2double(get(handles.T_Freq2,'string'))]/400;
P_opt=get(handles.P_datatype,'value');
check1=get(handles.c_baseline,'value');
if check1
    y_data=y_data-mean(y_data);
end

h=fdesign.bandpass('N,F3dB1,F3dB2',order,str2double(get(handles.T_Freq1,'string')), str2double(get(handles.T_Freq2,'string')), 800);
Hd = design(h, 'butter');
%[b,a]=butter(order,Wn,'bandpass');
%y_data=filter(b, a, y_data);
y_data=filter(Hd, y_data);

if P_opt==8 || P_opt==9
    axes(handles.axes3);
    plot(x_data,y_data)
    ylabel('Displacement / mm')
    xlabel('Time /s')
    grid on
    axes(handles.axes2);
    cla
    axes(handles.axes1);
    cla
else
    axes(handles.axes1);
    plot(x_data,y_data)
    ylabel('Acceleration /g')
    xlabel('Time /s')
    grid on
    
    axes(handles.axes2);
    v_data=cumsum(y_data*time_inc)*9.8e3;
    plot(x_data,v_data)
    ylabel('Velocity / mm/s')
    xlabel('Time /s')
    grid on
    
    axes(handles.axes3);
    s_data=cumsum(v_data*time_inc);
    plot(x_data,s_data)
    ylabel('Displacement / mm')
    xlabel('Time /s')
    grid on
end
save data/data_fil x_data y_data v_data s_data time_inc



function T_Filter_Order_Callback(hObject, eventdata, handles)
% hObject    handle to T_Filter_Order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Filter_Order as text
%        str2double(get(hObject,'String')) returns contents of T_Filter_Order as a double


% --- Executes during object creation, after setting all properties.
function T_Filter_Order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Filter_Order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Freq1_Callback(hObject, eventdata, handles)
% hObject    handle to T_Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Freq1 as text
%        str2double(get(hObject,'String')) returns contents of T_Freq1 as a double


% --- Executes during object creation, after setting all properties.
function T_Freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Freq2_Callback(hObject, eventdata, handles)
% hObject    handle to T_Freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Freq2 as text
%        str2double(get(hObject,'String')) returns contents of T_Freq2 as a double


% --- Executes during object creation, after setting all properties.
function T_Freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in c_baseline.
function c_baseline_Callback(hObject, eventdata, handles)
% hObject    handle to c_baseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_baseline


% --------------------------------------------------------------------
function Menu_Tools_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Menu_freq_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fig_Freq


% --- Executes on selection change in P_datatype.
function P_datatype_Callback(hObject, eventdata, handles)
% hObject    handle to P_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns P_datatype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P_datatype


% --- Executes during object creation, after setting all properties.
function P_datatype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_datatype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Tr1_Callback(hObject, eventdata, handles)
% hObject    handle to T_Tr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Tr1 as text
%        str2double(get(hObject,'String')) returns contents of T_Tr1 as a double


% --- Executes during object creation, after setting all properties.
function T_Tr1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Tr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_Tr2_Callback(hObject, eventdata, handles)
% hObject    handle to T_Tr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_Tr2 as text
%        str2double(get(hObject,'String')) returns contents of T_Tr2 as a double


% --- Executes during object creation, after setting all properties.
function T_Tr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_Tr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function filtervtool_Callback(hObject, eventdata, handles)
% hObject    handle to filtervtool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
order=str2double(get(handles.T_Filter_Order,'string'));
h=fdesign.bandpass('N,F3dB1,F3dB2',order,str2double(get(handles.T_Freq1,'string')), str2double(get(handles.T_Freq2,'string')), 800);
Hd = design(h, 'butter');
fvtool(Hd)
