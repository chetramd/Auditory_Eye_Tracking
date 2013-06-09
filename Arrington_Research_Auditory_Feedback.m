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
        radial_contrast_current_slider_pos = get(hObject,'Value');
        fprintf('%i\n',radial_contrast_current_slider_pos);

function Radial_Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%----------------- Radial Contrast : Color (Pull Down Menu)------------------------%
function Radial_Contrast_Colors_Callback(hObject, eventdata, handles)
        current_val = get(handles.Radial_Contrast_Colors,'Value');
        
        
        switch current_val
            case 1
                fprintf('%s\n','Red');
            case 2
                fprintf('%s\n','Orange');
            case 3
                fprintf('%s\n','Yellow');
            case 4
                fprintf('%s\n','Green');
            case 5
                fprintf('%s\n', 'Brown');
            case 6
                fprintf('%s\n','Indigo');
            otherwise
                fprintf('%s\n','Violet');
        end
                
           
                
    

function Radial_Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------- Radial Contrast : Change Color (Push Button)------------------------%
function Radial_Change_Color_Button_Callback(hObject, eventdata, handles)
            radial_selected_color = get(hObject,'Value');
            fprintf('%d\n',radial_selected_color);
            
%----------------- Radial Contrast : Change Background Image(Push Button)------------------------%
function Radial_Change_Background_Callback(hObject, eventdata, handles)
          [FileName,PathName] = uigetfile('*.jpg;*.png;*.gif','Select an Radial Background image');
          image=imread(strcat(PathName,FileName));
          axes(handles.Fixation_Point_Current_Symbol);
          imshow(image);
          
function Radial_Change_Background_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------------------------------------------------------------%

%--------------------------FIXATION POINT CONTRAST------------------------------%

%----------------- Fixation Point Contrast : Current Symbol(Axes)------------------------%
function Fixation_Point_Current_Symbol_CreateFcn(hObject, eventdata, handles)

%----------------- Fixation Point Contrast : Change Symbol (Push Button)------------------------%
function Fixation_Point_Change_Symbol_Callback(hObject, eventdata, handles)


%-----------------Fixation_Point Contrast : Luminance (Slider)------------------------%
function Fixation_Point_Contrast_Lum_Slider_Callback(hObject, eventdata, handles)
        fixation_contrast_current_slider_pos = get(hObject,'Value');
        fprintf('%i\n',fixation_contrast_current_slider_pos);

function Fixation_Point_Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%----------------- Fixation_Point Contrast : Color (Pull Down Menu)------------------------%
function Fixation_Point_Contrast_Colors_Callback(hObject, eventdata, handles)
        current_val2 = get(handles.Fixation_Point_Contrast_Colors,'Value');
        
        switch current_val2
            case 1
                fprintf('%s\n','Red');
            case 2
                fprintf('%s\n','Orange');
            case 3
                fprintf('%s\n','Yellow');
            case 4
                fprintf('%s\n','Green');
            case 5
                fprintf('%s\n', 'Brown');
            case 6
                fprintf('%s\n','Indigo');
            otherwise
                fprintf('%s\n','Violet');
        end
        
function Fixation_Point_Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------- Fixation_Point Contrast : Change Color (Push Button)------------------------%
function Fixation_Point_Change_Color_Button_Callback(hObject, eventdata, handles)

%----------------- Fixation_Point Contrast : Change Background Image(Push Button)------------------------%
function Fixation_Point_Change_Background_Button_Callback(hObject, eventdata, handles)
          [FileName,PathName] = uigetfile('*.jpg;*.png;*.gif','Select an Radial Background image');
          image2=imread(strcat(PathName,FileName));
          axes(handles.Fixation_Point_Current_Symbol);
          imshow(image2);
          

%-----------------------------------------------------------------------%

%--------------------------AUDITORY FEEDBACK--------------------------

%-----------------Auditory Feedback: Current Feedback Signal(Edit Text)------------------------%
function Current_Feedback_Signal_Text_CreateFcn(hObject, eventdata, handles)
         
%-----------------Auditory Feedback: Current Tone Frequency(Edit Text)------------------------%
function Current_Feedback_Freq_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Select Feedback Signal Type (Button Group)------------------------%
function Feedback_Signal_Types_Panel_CreateFcn(hObject, eventdata, handles)

function Feedback_Signal_Types_Panel_SelectionChangeFcn(hObject, eventdata, handles)
        
        % Initialize Feedback Signal
        feedback_tone = 'Tone';
        feedback_click = 'Click';
        
        % Gets Selected Feedback Signal
        selected_feedback_signal = get(eventdata.NewValue,'Tag');
        
        switch selected_feedback_signal 
            case 'Feedback_Signal_Tone'
                set(handles.Current_Feedback_Signal_Text,'String',feedback_tone);
            otherwise
                set(handles.Current_Feedback_Signal_Text,'String',feedback_click);
        end
        
         
%-----------------Patient's Eye Position: Change X Position (Static Text)------------------------%
function Current_X_Position_Text_CreateFcn(hObject, eventdata, handles)
        %set(handles.Current_X_Position_Text,'String','Hello');

%-----------------Patient's Eye Position: Change Y Position (Static Text)------------------------%
function Current_Y_Position_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Patient's Eye Position: Eye Position within AOI (Static Text)------------------------%
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
        % Get Number of Trials
         number_trials = get(handles.Number_Trials,'String');
         nt_string = str2double(number_trials);
         
        % Get Trial Duration
         trial_duration = get(handles.Trial_Duration,'String');
         td_string = str2double(trial_duration);
        
        % TEST
            % fs = 44,100 samples/s
            %[y,Fs] = wavread('sin_1kHz');
            % fs/i = slower sampling
            % fs*i = faster sampling
            
            Fs = 1000 ;  % Samples/s
            tFreq = 100; % Tone Freq - Hz
            s = 2;      % seconds
            w = 2*pi;
            t = linspace(0,s*tFreq*2*pi,round(s*Fs));
            y = sin(t);
            
        %
         
         
        % Trials Counter
        
        for i=1:nt_string
            % Stop Button Needs to Implemented
            
            
            samples = Fs*i;
            %freq_units = 'Hz';
            set(handles.Current_Trial_Text,'String',i);
            set(handles.Current_Feedback_Freq_Text,'String',samples);
            sound(y,samples);
            
            %pause(1);
            
        end
        
        
            
%-----------------Trials: Stop Trial (Push Button)------------------------%
function Stop_Trial_Button_Callback(hObject, eventdata, handles)


%-----------------Trials: Reset Trial (Push Button)------------------------%
function Reset_Trial_Button_Callback(hObject, eventdata, handles)
