function varargout = Fig_Freq(varargin)
% FIG_FREQ MATLAB code for Fig_Freq.fig
%      FIG_FREQ, by itself, creates a new FIG_FREQ or raises the existing
%      singleton*.
%
%      H = FIG_FREQ returns the handle to a new FIG_FREQ or the handle to
%      the existing singleton*.
%
%      FIG_FREQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIG_FREQ.M with the given input arguments.
%
%      FIG_FREQ('Property','Value',...) creates a new FIG_FREQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fig_Freq_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fig_Freq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fig_Freq

% Last Modified by GUIDE v2.5 21-Oct-2013 16:28:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fig_Freq_OpeningFcn, ...
                   'gui_OutputFcn',  @Fig_Freq_OutputFcn, ...
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


% --- Executes just before Fig_Freq is made visible.
function Fig_Freq_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fig_Freq (see VARARGIN)

% Choose default command line output for Fig_Freq
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

load data/data_fil
f0=fft(y_data);%/length(y_data)^0.5;
f=abs(f0);
l=fix(length(f)/2);
xf=(1:l)/l*400;

axes(handles.axes1);
plot(x_data,y_data)
ylabel('Acceleration /g')
xlabel('Time /s')
grid on

axes(handles.axes2);
plot(xf,f(1:l))
grid on

axes(handles.axes3);
f1=pcov(y_data,100);
%plot(xf,f1(1:l))
plot(f1)
grid on

% UIWAIT makes Fig_Freq wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fig_Freq_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function T_freq1_Callback(hObject, eventdata, handles)
% hObject    handle to T_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_freq1 as text
%        str2double(get(hObject,'String')) returns contents of T_freq1 as a double


% --- Executes during object creation, after setting all properties.
function T_freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_freq2_Callback(hObject, eventdata, handles)
% hObject    handle to T_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_freq2 as text
%        str2double(get(hObject,'String')) returns contents of T_freq2 as a double


% --- Executes during object creation, after setting all properties.
function T_freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_fresh.
function B_fresh_Callback(hObject, eventdata, handles)
% hObject    handle to B_fresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of B_fresh
load data/data_temp
f0=fft(y_data)/length(y_data)^0.5;
f=abs(f0);
l=fix(length(f)/2);
xf=(1:l)/l*400;
check1=get(handles.C_semilog,'value');

    axes(handles.axes1);
    plot(x_data,y_data)
    ylabel('Acceleration /g')
    xlabel('Time /s')
    grid on
    
if check1    
    axes(handles.axes2);
    freq1=str2double(get(handles.T_freq1,'string'));
    freq2=str2double(get(handles.T_freq2,'string'));
    x1=fix(freq1/400*l);
    if x1==0
        x1=1;
    end
    x2=fix(freq2/400*l);
    if x2>=length(f)
        x2=length(f);
    end
    
    semilogx(xf(x1:x2),f(x1:x2))
    grid on
    
    axes(handles.axes3);
    f1=abs(f0.*f0);
    semilogx(xf(x1:x2),f1(x1:x2))
    grid on
else
    axes(handles.axes2);
    freq1=str2double(get(handles.T_freq1,'string'));
    freq2=str2double(get(handles.T_freq2,'string'));
    x1=fix(freq1/400*l);
    if x1==0
        x1=1;
    end
    x2=fix(freq2/400*l);
    if x2>=length(f)
        x2=length(f);
    end
    
    plot(xf(x1:x2),f(x1:x2))
    grid on
    
    axes(handles.axes3);
    f1=abs(f0.*f0);
    plot(xf(x1:x2),f1(x1:x2))
    grid on
end


% --- Executes on button press in C_semilog.
function C_semilog_Callback(hObject, eventdata, handles)
% hObject    handle to C_semilog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of C_semilog
