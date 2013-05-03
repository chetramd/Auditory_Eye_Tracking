function varargout = Arrington_Research_Auditory_Feedback(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Arrington_Research_Auditory_Feedback_OpeningFcn, ...
                   'gui_OutputFcn',  @Arrington_Research_Auditory_Feedback_OutputFcn, ...
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


% --- Executes just before Arrington_Research_Auditory_Feedback is made visible.
function Arrington_Research_Auditory_Feedback_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Arrington_Research_Auditory_Feedback_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

%-----------------Area of Interest: Radial Size (Edit Text)-----------------%

function AOI_Radial_Size_Callback(hObject, eventdata, handles)
       
     
function AOI_Radial_Size_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
end

%-----------------Area of Interest: X-Position (Edit Text)------------------%


function AOI_X_Position_Callback(hObject, eventdata, handles)

function AOI_X_Position_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Area of Interest: Y-Position (Edit Text)------------------%

function AOI_Y_Position_Callback(hObject, eventdata, handles)
        
function AOI_Y_Position_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Area of Interest: Set Size (Push Button)------------------%
function AOI_Set_Size_Button_Callback(hObject, eventdata, handles)
           

%-----------------Area of Interest: Set Location (Push Button)------------------%
function AOI_Set_Location_Button_Callback(hObject, eventdata, handles)
        x_position = 4.16;
        y_position = 8.63;
        fprintf('%i\n',x_position);
        fprintf('%i\n',y_position);

%-----------------Contrast : Luminance (Slider)------------------------%
function Contrast_Lum_Slider_Callback(hObject, eventdata, handles)

function Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%-----------------Contrast : Color (Pull Down Menu)------------------------%
function Contrast_Colors_Callback(hObject, eventdata, handles)

function Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Contrast : Change Color (Push Button)------------------------%
function Change_Color_Button_Callback(hObject, eventdata, handles)

%-----------------Contrast : Change Background(Push Button)------------------------%
function Change_Background_Button_Callback(hObject, eventdata, handles)

%-----------------Fixation Point : Change Symbol(Push Button)------------------------%
function Change_Fixation_Symbol_Button_Callback(hObject, eventdata, handles)


%-----------------Auditory Feedback: Current Feedback Signal(Edit Text)------------------------%
function Current_Feedback_Signal_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Current Tone Frequency(Edit Text)------------------------%
function Current_Feedback_Freq_Text_CreateFcn(hObject, eventdata, handles)
