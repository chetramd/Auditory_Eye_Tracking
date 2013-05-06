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

%--------------------------AREA OF INTEREST------------------------------%

%-----------------Area of Interest: X-Position (Edit Text)------------------%

function AOI_X_Position_Callback(hObject, eventdata, handles)

function AOI_X_Position_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
       
%-----------------Area of Interest: Y-Position (Edit Text)------------------%

function AOI_Y_Position_Callback(hObject, eventdata, handles)

function AOI_Y_Position_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
       
        
%-----------------Area of Interest: Radial Size (Edit Text)-----------------%

function AOI_Radial_Size_Callback(hObject, eventdata, handles)

function AOI_Radial_Size_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
    
%-----------------Area of Interest: Set Size (Push Button)------------------%
function AOI_Set_Radial_Size_Button_Callback(hObject, eventdata, handles)
        radial_size = get(handles.AOI_Radial_Size,'String'); % Radial Size
        fprintf('%i\n',str2double(radial_size));   

%-----------------Area of Interest: Set Fixation Point (Push Button)------------------%
function AOI_Set_Fixation_Button_Callback(hObject, eventdata, handles) 
        eye_x_position = get(handles.AOI_X_Position,'String'); % Eye X Position
        eye_y_position = get(handles.AOI_Y_Position,'String'); % Eye Y Position
        fprintf('%i\n',str2double(eye_x_position));
        fprintf('%i\n',str2double(eye_y_position));

%-----------------------------------------------------------------------%

%--------------------------RADIAL CONTRAST------------------------------%

%-----------------Radial Contrast : Luminance (Slider)------------------------%
function Radial_Contrast_Lum_Slider_Callback(hObject, eventdata, handles)
        current_slider_pos = get(hObject,'Value');
        fprintf('%i\n',current_slider_pos);

function Radial_Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%----------------- Radial Contrast : Color (Pull Down Menu)------------------------%
function Radial_Contrast_Colors_Callback(hObject, eventdata, handles)

function Radial_Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------- Radial Contrast : Change Color (Push Button)------------------------%
function Radial_Change_Color_Button_Callback(hObject, eventdata, handles)

%----------------- Radial Contrast : Change Background Image(Push Button)------------------------%
function Radial_Change_Background_Button_Callback(hObject, eventdata, handles)


%-----------------------------------------------------------------------%

%--------------------------FIXATION POINT CONTRAST------------------------------%

%----------------- Fixation Point Contrast : Current Symbol(Axes)------------------------%
function Fixation_Point_Current_Symbol_CreateFcn(hObject, eventdata, handles)

%----------------- Fixation Point Contrast : Change Symbol (Push Button)------------------------%
function Fixation_Point_Change_Symbol_Callback(hObject, eventdata, handles)


%-----------------Fixation_Point Contrast : Luminance (Slider)------------------------%
function Fixation_Point_Contrast_Lum_Slider_Callback(hObject, eventdata, handles)

function Fixation_Point_Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%----------------- Fixation_Point Contrast : Color (Pull Down Menu)------------------------%
function Fixation_Point_Contrast_Colors_Callback(hObject, eventdata, handles)

function Fixation_Point_Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------- Fixation_Point Contrast : Change Color (Push Button)------------------------%
function Fixation_Point_Change_Color_Button_Callback(hObject, eventdata, handles)

%----------------- Fixation_Point Contrast : Change Background Image(Push Button)------------------------%
function Fixation_Point_Change_Background_Button_Callback(hObject, eventdata, handles)


%-----------------------------------------------------------------------%

%--------------------------AUDITORY FEEDBACK--------------------------

%-----------------Auditory Feedback: Current Feedback Signal(Edit Text)------------------------%
function Current_Feedback_Signal_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Current Tone Frequency(Edit Text)------------------------%
function Current_Feedback_Freq_Text_CreateFcn(hObject, eventdata, handles)

%-----------------Auditory Feedback: Feedback Signal Types (Radio Button)------------------------%
function Feedback_Signal_Types_CreateFcn(hObject, eventdata, handles)

function Feedback_Signal_Types_SelectionChangeFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Change Feedback Signal(Push Button)------------------------%
function Change_Feedback_Signal_Type_Callback(hObject, eventdata, handles)

%-----------------Auditory Feedback: Change X Position (Static Text)------------------------%
function Current_X_Position_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Change Y Position (Static Text)------------------------%
function Current_Y_Position_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Eye Position within AOI (Static Text)------------------------%
function Eye_Position_Area_Interest_Text_CreateFcn(hObject, eventdata, handles)

%-----------------------------------------------------------------------%

%--------------------------TRIALS---------------------------------------------------%

%-----------------Trials: Number of Trials (Edit Text)------------------------%
function Number_Trials_Callback(hObject, eventdata, handles)

function Number_Trials_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-----------------Trials: Trial Duration (seconds) (Edit Text)------------------------%
function Trial_Duration_Callback(hObject, eventdata, handles)

function Trial_Duration_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Trials: Current Trial (Static Text)------------------------%
function Current_Trial_Text_CreateFcn(hObject, eventdata, handles)

%-----------------Trials: Run Trial (Push Button)------------------------%
function Run_Trial_Button_Callback(hObject, eventdata, handles)

%-----------------Trials: Stop Trial (Push Button)------------------------%
function Stop_Trial_Button_Callback(hObject, eventdata, handles)
