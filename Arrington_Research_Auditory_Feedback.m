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

    % Start variables
    global start
    start = 0;
    
    % Generate Handles Output
    handles.output = hObject;
    
    % Generate GUI using hObjects
    guidata(hObject, handles);
    
    clc; clear all;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     time=1:50;
%     eye_x_position = zeros(1,50);
%     eye_y_position = zeros(1,50);
%     %axes(handles.axes2);
%     hLine=plot(time,eye_x_position);ylim([0 1]);
% 
%     stripchart('Initialize',gca)
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     % Set Axes on AOI Axes
%     axes(handles.AOI_Axes);
% 
%     global eye_data
%     eye_data = 0;
% 
%     global check
%     check = 0;
% 
%     count = 0;
%     
%     while(check ~= 1)
% 
%         % Retrieve Eye X and Y Position from Viewpoint DLL
%         gaze_Positions=struct('x',0.5,'y',0.5); 
%         [gaze_Positions.x,gaze_Positions.y] = vpx_GetGazePointSmoothed(eye_data);
%  
%         % Update AOI_Axes with gaze_Positions (X and Y)
%         eye_x_position(count)= gaze_Positions.x;
%         eye_y_position(count)= gaze_Positions.y;
%         
%         % Update Axes
%         stripchart('Update',hLine,yposition(i));
% 
%         %Set the gaze point on the gaze plot.
%  
%         plot(eye_x_position(count),eye_y_position(count),'*','MarkerSize',12);
%         xlim([0 1]); ylim([0 1]);
%  
%         handles = AOI_Set_Fixation_Button_Callback(handles.AOI_Set_Fixation_Radial_Size_Button,eventdata,handles);
%         handles1 = AOI_Set_Radial_Size_Button_Callback(handles.AOI_Set_Radial_Size_Button,eventdata,handles);
%         handles2 = Feedback_Signal_Types_Panel_SelectionChangeFcn(handles.Feedback_Signal_Types_Panel,eventdata,handles);
%  
%         fp_x_position = get(handles.AOI_X_Position,'String'); % Eye X Position
%         fp_y_position = get(handles.AOI_Y_Position,'String');
%         fp_radius = get(handles1.AOI_Radial_Size,'String');
%  
%         selected_feedback_signal = get(eventdata.NewValue,'Tag');
%  
%         % Gaze Point x
%         x2 = xposition(i);
%  
%         % Gaze Point y
%         y2 = yposition(i);
%  
%         % FP x
%         x1 = str2double(fp_x_position);
%  
%         % FP y
%         y1 = str2double(fp_y_position);
%  
%         % Distance
%         distance = sqrt(((x2-x1)^2)+(y2-y1)^2);
%  
%  
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         floor = .002;
%         coef = 1;
%         if distance > floor
%             frequency = coef*(1/(.01*distance));
%         else
%             frequency = coef*(1/floor);
%         end
%  
%         Fs =1000;
%         nSeconds = .05;
%  
%         y = 100*sin(linspace(0, nSeconds*frequency*2*pi, round(nSeconds*Fs)));
%         sound(y, Fs);
%  
%         
%         % Set Static Text(Patient's Eye Position): If Eye Position is
%         % within AOI (Yes or No)
%         
%         if(distance <= str2double(fp_radius))
%             set(handles.Eye_Position_Area_Interest_Text,'String','YES');
%         else
%             set(handles.Eye_Position_Area_Interest_Text,'String','NO');
%         end
%  
%  
%         % Set Current X and Y Position into Static Texts (Patient's Eye
%         % Position)
%         
%         set_Current_X_Position = str2double(eye_x_position(count));
%         set_Current_Y_Position = str2double( eye_y_position(count));
%         
%         set(handles.Current_X_Position_Text,'String',set_Current_X_Position);
%         set(handles.Current_Y_Position_Text,'String',set_Current_Y_Position);
%  
%         % Iterate through real time data from Viewpoint
%         count = count +1;
%         start = 1;
%     end
%     delete(hObject);

% --- Outputs from this function are returned to the command line.
function varargout = Arrington_Research_Auditory_Feedback_OutputFcn(hObject, eventdata, handles) 

    global flag

    if(flag == 0)
        varargout{1} = handles.output;  
    end
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
    

%-----------------Area of Interest: Set Fixation Point and Radial Size (Push Button)------------------%
function [handles] =  AOI_Set_Fixation_Radial_Size_Button_Callback(hObject, eventdata, handles) 
        
        % Get Fixation Point and Radial for AOI
        eye_x_position = get(handles.AOI_X_Position,'String'); 
        eye_y_position = get(handles.AOI_Y_Position,'String');
        radial_size = get(handles.AOI_Radial_Size,'String');
        
        % Set Parametric Equations for Circle
        t = linspace(0,2*pi,1000);
        x = str2double(radial_size)*cos(t) + str2double(get(handles.AOI_X_Position,'String'));
        y = str2double(radial_size)*sin(t) + str2double(get(handles.AOI_Y_Position,'String'));
        
        % Set Axes for AOI_Axes
        axes(handles.AOI_Axes);
        set(gca,'XTick',[],'YTick',[])
        
        % Plot Radial Size
        fill(x,y,'w');
        xlim([0,1]); ylim([0,1]);
        hold on
        
        % Plot Fixation Point
        plot(str2double(eye_x_position),str2double(eye_y_position),'x','MarkerSize',15,'Color','r');
        
        hold off
        axis([0 1 0 1])

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
        
        % Current Selected Color
        current_color = get(handles.Radial_Contrast_Colors,'Value');
        
        % Current Eye X Position
        cur_eye_x = str2double(get(handles.AOI_X_Position,'String'));
        % Current Eye Y Position
        cur_eye_y = str2double(get(handles.AOI_Y_Position,'String'));
        
        % Current Radial Size
        cur_radial_size = str2double(get(handles.AOI_Radial_Size,'String'));
        
        
        % Parametric Equations of AOI
        t = linspace(0,2*pi,1000);
        x1 = cur_radial_size*cos(t) + cur_eye_x;
        y1 = cur_radial_size*sin(t) + cur_eye_y;
        
        axes(handles.AOI_Axes); 
        
        switch current_color
            case 1
                % White AOI
                fill(x1,y1,'w');
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])

            case 2
                % Red AOI
                fill(x1,y1,'r');
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 3
                % Orange AOI
                orange = [1 0.8 0.3];
                fill(x1,y1,orange);
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 4
                % Yellow AOI
                fill(x1,y1,'y');
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 5
                % Green AOI
                fill(x1,y1,'g');
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 6
                % Brown AOI
                brown = [.7 .5 0];
                fill(x1,y1,brown);
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 7
                % Indigo (Blue) AOI
                fill(x1,y1,'b');
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            otherwise
                % Violet AOI
                violet = [0.6 0 1];
                fill(x1,y1,violet);
                hold on
       
                plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
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
        
        % Current Selected Color
        current_color2 = get(handles.Fixation_Point_Contrast_Colors,'Value');
        
        % Current Eye X Position
        cur_eye_x2 = str2double(get(handles.AOI_X_Position,'String'));
        % Current Eye Y Position
        cur_eye_y2 = str2double(get(handles.AOI_Y_Position,'String'));
        
        % Current Radial Size
        cur_radial_size = str2double(get(handles.AOI_Radial_Size,'String'));
        
        % Current AOI Color
        
        cur_AOI_Color = get(handles.Radial_Contrast_Colors,'Value');
        
        switch cur_AOI_Color
            case 1
                set_Color = 'w';
            case 2
                set_Color = 'r';
            case 3
                orange = [1 0.8 0.3];
                set_Color = orange;
            case 4
                set_Color = 'y';
            case 5
                set_Color = 'g';
            case 6
                brown = [.7 .5 0];
                set_Color = brown;
            case 7
                set_Color ='b';
                
            otherwise    
                violet = [0.6 0 1];
                set_Color = violet;
        end
              
        
        
        
        % Parametric Equations of AOI
        t = linspace(0,2*pi,1000);
        x12 = cur_radial_size*cos(t) + cur_eye_x2;
        y12 = cur_radial_size*sin(t) + cur_eye_y2;
        
        axes(handles.AOI_Axes); 
        
        switch current_color2
            case 1
                % White FP
                
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','w');
        
                hold off
                axis([0 1 0 1])

            case 2
                % Red FP
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','r');
        
                hold off
                axis([0 1 0 1])
                
            case 3
                % Orange FP
                orange = [1 0.8 0.3];
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',orange);
        
                hold off
                axis([0 1 0 1])
                
            case 4
                % Yellow FP
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','y');
        
                hold off
                axis([0 1 0 1])
                
            case 5
                % Green FP
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','g');
        
                hold off
                axis([0 1 0 1])
                
            case 6
                % Brown
                brown = [.7 .5 0];
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',brown);
        
                hold off
                axis([0 1 0 1])
                
            case 7
                % Indigo (Blue)
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','b');
        
                hold off
                axis([0 1 0 1])
                
            otherwise
                % Violet
                violet = [0.6 0 1];
                fill(x12,y12,set_Color);
                hold on
       
                plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',violet);
        
                hold off
                axis([0 1 0 1])
                
        end
        
function Fixation_Point_Contrast_Colors_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Fixation_Symbol_Panel_CreateFcn(hObject, eventdata, handles)

function Fixation_Symbol_Panel_SelectionChangeFcn(hObject, eventdata, handles)
        Numbers = {'0' '1' '2' '3' '4' '5' '6' '7' '8 ' '9'};
        Letters = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' ...
            'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
        Shapes = {'Square', 'Rectangle','Triangle','Circle','Ellipse'};
            
        selected_fixation_symbol = get(eventdata.NewValue,'Tag');
        
        switch selected_fixation_symbol
            case 'FP_Numbers'
                set(handles.Current_FP_ListBox,'String',Numbers);
            case 'FP_Letters'
                set(handles.Current_FP_ListBox,'String',Letters);
            otherwise
                set(handles.Current_FP_ListBox,'String',Shapes);
        end



function Current_FP_ListBox_Callback(hObject, eventdata, handles)
        Numbers1 = {'0' '1' '2' '3' '4' '5' '6' '7' '8 ' '9'};
        Letters1 = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' ...
            'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
        Shapes1 = {'Square', 'Rectangle','Triangle','Circle','Ellipse'};
        
        selected_item = get(handles.Current_FP_ListBox,'Value'); 
        selected_FP_Symbol = get(handles.Fixation_Symbol_Panel,'SelectedObject');
        selectFP_Sym = get(selected_FP_Symbol,'Tag');
        
        switch selectFP_Sym
            case 'FP_Numbers'
                test = Numbers1{selected_item};
                fprintf('%i\n',str2double(test));
            case 'FP_Letters'
                test1 = Letters1{selected_item};
                fprintf('%s\n',test1);    
            otherwise
                test2 = Shapes1{selected_item};
                fprintf('%s\n',test2);
            
        end
        
        

function Current_FP_ListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

          

%-----------------------------------------------------------------------%

%--------------------------AUDITORY FEEDBACK--------------------------

%-----------------Auditory Feedback: Current Feedback Signal(Edit Text)------------------------%
function Current_Feedback_Signal_Text_CreateFcn(hObject, eventdata, handles)
         
%-----------------Auditory Feedback: Current Tone Frequency(Edit Text)------------------------%
function Current_Feedback_Freq_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Auditory Feedback: Select Feedback Signal Type (Button Group)------------------------%
function Feedback_Signal_Types_Panel_CreateFcn(hObject, eventdata, handles)

function [handles2] = Feedback_Signal_Types_Panel_SelectionChangeFcn(hObject, eventdata, handles)
        
        % Initialize Feedback Signal
        feedback_tone = 'Tone';
        feedback_click = 'Click';
        
        % Gets Selected Feedback Signal
        selected_feedback_signal = get(eventdata.NewValue,'Tag');
        
%         switch selected_feedback_signal 
%             case 'Feedback_Signal_Tone'
%                 set(handles.Current_Feedback_Signal_Text,'String',feedback_tone);
%             otherwise
%                 set(handles.Current_Feedback_Signal_Text,'String',feedback_click);
%         end
        
function Current_X_Position_Text_Callback(hObject, eventdata, handles)         
%-----------------Patient's Eye Position: Change X Position (Static Text)------------------------%
function Current_X_Position_Text_CreateFcn(hObject, eventdata, handles)
        %set(handles.Current_X_Position_Text,'String','Hello');

%-----------------Patient's Eye Position: Change Y Position (Static Text)------------------------%
function Current_Y_Position_Text_Callback(hObject, eventdata, handles)

function Current_Y_Position_Text_CreateFcn(hObject, eventdata, handles)


%-----------------Patient's Eye Position: Eye Position within AOI (Static Text)------------------------%
function Eye_Position_Area_Interest_Text_CreateFcn(hObject, eventdata, handles)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global start
global flag

if(start==1)
    % Signal the openingFcn to end and let it close the figure.
    flag = 1;
else
    % We close the figure.
    delete(hObject);
end

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





