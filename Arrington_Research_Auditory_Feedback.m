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
    
    clc;

    %% Loading dynamically linked library from Viewpoint
    
    % DLL Location
    dll_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\VPX_InterApp.dll';
    % SDK Location
    sdk_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\SDK\';
    % Header Location
    header_location = strcat(sdk_location,'vpx.h');
    toolbox_location = strcat(sdk_location,'vptoolbox.h');
    
    % Initialize Connection to Viewpoint DLL
    vpx_Initialize(dll_location,header_location,toolbox_location);
    
    
    %% Initialize Variables
    
    % Start variables
    global start
    start = 0;
    
    % Generate Handles Output
    handles.output = hObject;
    
    % Generate GUI using hObjects
    guidata(hObject, handles);
    
    % Initialize Eye X and Y Positions
    eye_x_position = zeros(1,50);
    eye_y_position = zeros(1,50);
    
    % Set Axes on AOI Axes
    axes(handles.AOI_Axes);
    
    %% Retrieve Eye Information from Viewpoint
    global eye_data
    eye_data = 0;

    global check
    check = 0;

    count = 1;
    
    while(check ~= 1)
        %% AREA OF INTEREST
        
        % Get X and Y Gaze Positions from Viewpoint
        gaze_Positions=struct('x',0.5,'y',0.5); 
        [gaze_Positions.x,gaze_Positions.y] = vpx_GetGazePointSmoothed(eye_data);
        
        % Get Iteration from Gaze Positions
        eye_x_position(count)= gaze_Positions.x;
        eye_y_position(count)= gaze_Positions.y;
        
        % Get Handles from Functions
        handles  = AOI_Set_Fixation_Radial_Size_Button_Callback(handles.AOI_Set_Fixation_Radial_Size_Button,eventdata,handles);
        handles1 = Radial_Contrast_Colors_Callback(handles.Radial_Contrast_Colors,eventdata,handles);
        handles2 = Fixation_Point_Contrast_Colors_Callback(handles.Fixation_Point_Contrast_Colors,eventdata,handles);
        handles3 = Feedback_Signal_Types_Panel_SelectionChangeFcn(handles.Feedback_Signal_Types_Panel,eventdata,handles);
        handles4 = Radial_Contrast_Lum_Slider_Callback(handles.Radial_Contrast_Lum_Slider,eventdata,handles);
        handles5 = Run_Trial_Button_Callback(handles.Run_Trial_Button, eventdata, handles);
        
        % Get Fixation Point Positions from Static Fields 
        fp_x_position = get(handles.AOI_X_Position,'String'); 
        fp_y_position = get(handles.AOI_Y_Position,'String');
        fp_radius = get(handles.AOI_Radial_Size,'String');
        
        % Gaze Point x
        x2 = eye_x_position(count);
        % Gaze Point y
        y2 = eye_y_position(count);
        % Fixation Pt x
        x1 = str2double(fp_x_position);
        % Fixation Pt y
        y1 = str2double(fp_y_position);
 
        % Distance from AOI to Current Fixation Pt
        distance = sqrt(((x2-x1)^2)+(y2-y1)^2);
        
        % Circle Formulas
        t = linspace(0,2*pi,1000);
        x = str2double(fp_radius)*cos(t) + str2double(fp_x_position);
        y = str2double(fp_radius)*sin(t) + str2double(fp_y_position);
        
        % Plot Eye X and Y Positions in AOI Axes
       
        plot(eye_x_position(count),eye_y_position(count),'*','MarkerSize',12);
        xlim([0 1]); ylim([0 1]);
        hold on
        
        % Plot AOI and Fixation Point
        plot(x,y);
        
        hold on
        plot(str2double(fp_x_position),str2double(fp_y_position));
        
        
        %% AREA OF INTEREST Contrast
        
        %%%%%%%%%%%%%%%% AOI Luminance Slider %%%%%%%%%%%%%%%%%%%%%%%%
        
        % Get Slider Value
        radial_contrast_current_slider_pos = get(handles4.Radial_Contrast_Lum_Slider,'Value');
        % Get Current Color
        current_color = get(handles1.Radial_Contrast_Colors,'Value');
        
        
        if(current_color <= 1)
%             fprintf('%s\n','No Color No Lum');
        else
            % Set Color to AOI Region
            % RED - [1 0 0]
            % ORANGE - [1 0.8 0.3]
            % YELLOW -  [1 1 0]
            % GREEN - [0 1 0]
            % BROWN - [.7 .5 0]
            % INDIGO - [0 0 1]
            % VIOLET - [1 0 1]
            
            switch current_color
                case 1
                    % No Color
                    plot(x,y);
                    hold on
                    axis([0 1 0 1])
                case 2
                    % Red AOI
                    if(radial_contrast_current_slider_pos <= 10)
                        % 1st Stage RED
                        %xlim([0 1]); ylim([0 1]);
                        fill(x,y,[1 0 0]);
                        axis([0 1 0 1])
                        hold on
                        %xlim([0 1]); yli
                        
                        fprintf('%s\n','Red 1st Stage');
                    elseif (radial_contrast_current_slider_pos >= 10 && radial_contrast_current_slider_pos <= 20)
                        fill(x,y,[0.95 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 2nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 20 && radial_contrast_current_slider_pos <= 30)
                        fill(x,y,[0.9 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 3nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 30 && radial_contrast_current_slider_pos <= 40)
                        fill(x,y,[0.85 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 4nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 40 && radial_contrast_current_slider_pos <= 50)
                        fill(x,y,[0.8 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 5nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 50 && radial_contrast_current_slider_pos <= 60)
                        fill(x,y,[0.75 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 6nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 60 && radial_contrast_current_slider_pos <= 70)
                        fill(x,y,[0.7 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 7nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 70 && radial_contrast_current_slider_pos <= 80)
                        fill(x,y,[0.65 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 8nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 80 && radial_contrast_current_slider_pos <= 90)
                        fill(x,y,[0.6 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 9nd Stage');
                    else
                        % 90 to 100
                        fill(x,y,[0.5 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 10nd Stage');
                    end
                case 3
                    if(radial_contrast_current_slider_pos <= 10)
                        % 1st Stage ORANGE
                        %xlim([0 1]); ylim([0 1]);
                        fill(x,y,[1 0 0]);
                        axis([0 1 0 1])
                        hold on
                        %xlim([0 1]); yli
                        
                        fprintf('%s\n','Red 1st Stage');
                    elseif (radial_contrast_current_slider_pos >= 10 && radial_contrast_current_slider_pos <= 20)
                        fill(x,y,[0.95 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 2nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 20 && radial_contrast_current_slider_pos <= 30)
                        fill(x,y,[0.9 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 3nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 30 && radial_contrast_current_slider_pos <= 40)
                        fill(x,y,[0.85 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 4nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 40 && radial_contrast_current_slider_pos <= 50)
                        fill(x,y,[0.8 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 5nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 50 && radial_contrast_current_slider_pos <= 60)
                        fill(x,y,[0.75 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 6nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 60 && radial_contrast_current_slider_pos <= 70)
                        fill(x,y,[0.7 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 7nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 70 && radial_contrast_current_slider_pos <= 80)
                        fill(x,y,[0.65 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 8nd Stage');
                    elseif (radial_contrast_current_slider_pos >= 80 && radial_contrast_current_slider_pos <= 90)
                        fill(x,y,[0.6 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 9nd Stage');
                    else
                        % 90 to 100
                        fill(x,y,[0.5 0 0]);
                        hold on
                        axis([0 1 0 1])
                        fprintf('%s\n','Red 10nd Stage');
                    end
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Color Pull Down & Luminance Slider
%         current_clr = get(handles1.Radial_Contrast_Colors,'Value');
%         
%         switch current_clr
%             case 1
%                 % No Color AOI
%                 plot(x,y);
%                 hold on
%                 axis([0 1 0 1])
%                 
%             case 2
%                 % Red AOI
%                 fill(x,y,'r');
%                 hold on
%                 axis([0 1 0 1])
%                 
%             case 3
%                 % Orange AOI
%                 orange = [1 0.8 0.3];
%                 fill(x,y,orange);
%                 hold on
%                 axis([0 1 0 1])
%                 
%             case 4
%                 % Yellow AOI
%                 fill(x,y,'y');
%                 hold on
%                 axis([0 1 0 1])
%                 
%             case 5
%                 % Greem AOI
%                 fill(x,y,'g');
%                 hold on
%                 axis([0 1 0 1])
%                
%             case 6
%                 % Brown AOI
%                 brown = [.7 .5 0];
%                 fill(x,y,brown);
%                 hold on
%                 axis([0 1 0 1])
%                 
%             case 7
%                 % Indigo (Blue) AOI
%                 fill(x,y,'b');
%                 hold on
%                 axis([0 1 0 1])
%                 
%             otherwise
%                 % Violet AOI
%                 violet = [0.6 0 1];
%                 fill(x,y,violet);
%                 hold on
%                 axis([0 1 0 1])
%                 
%         end
%         
        
        
        %% FIXATION POINT CONTRAST
        current_clr2 = get(handles2.Fixation_Point_Contrast_Colors,'Value');
        
        switch current_clr2
            case 1
                % No Color FP
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15);
                hold off
                axis([0 1 0 1])
            case 2
                % White FP
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color','w');
                hold off
                axis([0 1 0 1])
                
            case 3
                % Red FP
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color','r');
                hold off
                axis([0 1 0 1])
                
            case 4
                % Orange FP
                orange = [1 0.8 0.3];
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color',orange);
                hold off
                axis([0 1 0 1])
                
            case 5
                % Yellow FP
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color','y');
                hold off
                axis([0 1 0 1]) 
                
            case 6
                % Green FP
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color','g');
                hold off
                axis([0 1 0 1])
                  
            case 7
                % Brown
                brown = [.7 .5 0];
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color',brown);
                hold off
                axis([0 1 0 1]) 
                
            case 8
                % Indigo (Blue)
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color','b')
                hold off
                axis([0 1 0 1])
                
            otherwise
                % Violet
                violet = [0.6 0 1];
                plot(str2double(fp_x_position),str2double(fp_y_position),'x','MarkerSize',15,'Color',violet);
                hold off
                axis([0 1 0 1])      
        end
        
        %% PATIENT'S EYE POSITION PANEL
        
        % Set Static Text(Patient's Eye Position): If Eye Position is within AOI (Yes or No)
         
        if(distance <= str2double(fp_radius))
            set(handles.Eye_Position_Area_Interest_Text,'String','YES');
        else
            set(handles.Eye_Position_Area_Interest_Text,'String','NO');
        end
 
 
        % Set Current X and Y Position into Static Texts (Patient's Eye Position Panel)
        
        set_Current_X_Position = num2str(eye_x_position(count));
        set_Current_Y_Position = num2str(eye_y_position(count));
        set(handles.Current_X_Position_Text,'String',set_Current_X_Position);
        set(handles.Current_Y_Position_Text,'String',set_Current_Y_Position);
 
        %% AUDITORY FEEDBACK PANEL
       
        % Gets Selected Button from UIButtonGroup
        selected_feedback_signal = get(handles.Feedback_Signal_Types_Panel,'SelectedObject');
        % Selected Tag for Selected Feedback Signal
        select_Tag = get(selected_feedback_signal,'Tag');
        
        switch select_Tag
            case 'Feedback_Signal_Tone'
                % Feedback Signal: Tone
%                 fprintf('%s\n', 'Tone');
            otherwise
                % Feedback Signal: Click
                % Point Circle Collision Detection
                
                % Distance from Center of Circle to Point
                distance_Center_to_Point_X = str2double(fp_x_position) - eye_x_position(count);
                distance_Center_to_Point_Y = str2double(fp_y_position) - eye_y_position(count);
                
                % Length from Center to Point
                length_Center_to_Point = sqrt((distance_Center_to_Point_X).^2 +(distance_Center_to_Point_Y).^2);
                
                radius_fp = str2double(fp_radius);
                
                % Store previous distance into array
                
                
                
                % test = 0;
                
                new_distance  =  length_Center_to_Point + 1;
                previous_distance  =  new_distance -1;
                
%                  fprintf('%i\n',new_distance);
%                   fprintf('%i\n',previous_distance);
                
                
                if((new_distance > radius_fp) && (previous_distance < radius_fp ))
                    % Click (moving from inner to outer
%                       fprintf('%s\n','No Click');
                    [y,Fs] = wavread('click_sound.wav');
                    sound(y,Fs)
                else
%                         fprintf('%s\n','No Click');
                        
                end
                   
                        
                           
                    
                    
%                     fprintf('%s\n','Click');
%                     
%                     % Read Click WAV file
%                     [y,Fs] = wavread('click_sound.wav');
%                     sound(y,Fs);
                    
                    
%                 else
%                     fprintf('%s\n','No Click');
%                 end
        end
        
        


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
        %sound(y, Fs);
        %% Experimental Trials
        
        number_trials = str2double(get(handles5.Number_Trials,'String'));
        trial_duration = str2double(get(handles5.Trial_Duration,'String'));
        toggle_state = get(handles5.Run_Trial_Button,'Value');
        
        if(toggle_state == 0)
           % Not Pressed 
        else
           % Toggle is Pressed
           
           % Iterate through Number of Trials
           wait = 1;
           
           for i = 1:number_trials
                % Set Current Trial Executing
                set(handles.Current_Trial_Text,'String',i);
            
                % Set Text File Specifications
                t = 'trial_';
                s = '.txt';
                r = num2str(i);
                trial_txt = strcat(t,r,s);
                
                
               % Get Real Time Eye X and Y Data
               
               while(check ~= 1)
                   fprintf('%f  %f\n',eye_x_position(wait),eye_y_position(wait));
                
                   wait= wait+1;
                   
               end
               
               %wait = 1;
           end
            
            % Release Toggle
            set(handles5.Run_Trial_Button,'Value',0);
            
            
        end
        
        
        %% Iterate through real time data from Viewpoint
        
        count = count +1;
        start = 1;
    end
    delete(hObject);

% --- Outputs from this function are returned to the command line.
function varargout = Arrington_Research_Auditory_Feedback_OutputFcn(hObject, eventdata, handles) 

    global check
    if(check == 0)
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
%         eye_x_position = get(handles.AOI_X_Position,'String'); 
%         eye_y_position = get(handles.AOI_Y_Position,'String');
%         radial_size = get(handles.AOI_Radial_Size,'String');
%         
%         % Set Parametric Equations for Circle
%         t = linspace(0,2*pi,1000);
%         x = str2double(radial_size)*cos(t) + str2double(get(handles.AOI_X_Position,'String'));
%         y = str2double(radial_size)*sin(t) + str2double(get(handles.AOI_Y_Position,'String'));
%         
%         % Set Axes for AOI_Axes
%         axes(handles.AOI_Axes);
%         set(gca,'XTick',[],'YTick',[])
%         
%         % Plot Radial Size
%         fill(x,y,'w');
%         xlim([0,1]); ylim([0,1]);
%         hold on
%         
%         % Plot Fixation Point
%         plot(str2double(eye_x_position),str2double(eye_y_position),'x','MarkerSize',15,'Color','r');
%         
%         hold off
%         axis([0 1 0 1])

%-----------------------------------------------------------------------%




%--------------------------RADIAL CONTRAST------------------------------%

%-----------------Radial Contrast : Luminance (Slider)------------------------%
function [handles] = Radial_Contrast_Lum_Slider_Callback(hObject, eventdata, handles)
%         radial_contrast_current_slider_pos = get(hObject,'Value');
%         
%         if(radial_contrast_current_slider_pos <= 10)
%             fprintf('%s\n','1st Stage');
%         elseif (radial_contrast_current_slider_pos >= 10 && radial_contrast_current_slider_pos <= 20)
%             fprintf('%s\n','2nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 20 && radial_contrast_current_slider_pos <= 30)
%             fprintf('%s\n','3nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 30 && radial_contrast_current_slider_pos <= 40)
%             fprintf('%s\n','4nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 40 && radial_contrast_current_slider_pos <= 50)
%             fprintf('%s\n','5nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 50 && radial_contrast_current_slider_pos <= 60)
%             fprintf('%s\n','6nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 60 && radial_contrast_current_slider_pos <= 70)
%             fprintf('%s\n','7nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 70 && radial_contrast_current_slider_pos <= 80)
%             fprintf('%s\n','8nd Stage');
%         elseif (radial_contrast_current_slider_pos >= 80 && radial_contrast_current_slider_pos <= 90)
%             fprintf('%s\n','9nd Stage');
%         else
%             % 90 to 100
%             fprintf('%s\n','10nd Stage');
%         end
          
function Radial_Contrast_Lum_Slider_CreateFcn(hObject, eventdata, handles)

    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);  
    end

%----------------- Radial Contrast : Color (Pull Down Menu)------------------------%
function [handles] = Radial_Contrast_Colors_Callback(hObject, eventdata, handles)
        
        % Current Selected Color
%         current_color = get(handles.Radial_Contrast_Colors,'Value');
        
%         % Current Eye X Position
%         cur_eye_x = str2double(get(handles.AOI_X_Position,'String'));
%         % Current Eye Y Position
%         cur_eye_y = str2double(get(handles.AOI_Y_Position,'String'));
%         
%         % Current Radial Size
%         cur_radial_size = str2double(get(handles.AOI_Radial_Size,'String'));
%         
%         
%         % Parametric Equations of AOI
%         t = linspace(0,2*pi,1000);
%         x1 = cur_radial_size*cos(t) + cur_eye_x;
%         y1 = cur_radial_size*sin(t) + cur_eye_y;
%         
%        axes(handles.AOI_Axes); 
        
%         switch current_color
%             case 1
%                 % White AOI
%                 fill(x1,y1,'w');
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
% 
%             case 2
%                 % Red AOI
%                 fill(x1,y1,'r');
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 3
%                 % Orange AOI
%                 orange = [1 0.8 0.3];
%                 fill(x1,y1,orange);
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 4
%                 % Yellow AOI
%                 fill(x1,y1,'y');
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 5
%                 % Green AOI
%                 fill(x1,y1,'g');
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 6
%                 % Brown AOI
%                 brown = [.7 .5 0];
%                 fill(x1,y1,brown);
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 7
%                 % Indigo (Blue) AOI
%                 fill(x1,y1,'b');
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             otherwise
%                 % Violet AOI
%                 violet = [0.6 0 1];
%                 fill(x1,y1,violet);
%                 hold on
%        
%                 plot(cur_eye_x,cur_eye_y,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%         end
                
           
                
    

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
function [handles] = Fixation_Point_Contrast_Colors_Callback(hObject, eventdata, handles)
        
%         % Current Selected Color
%         current_color2 = get(handles.Fixation_Point_Contrast_Colors,'Value');
%         
%         % Current Eye X Position
%         cur_eye_x2 = str2double(get(handles.AOI_X_Position,'String'));
%         % Current Eye Y Position
%         cur_eye_y2 = str2double(get(handles.AOI_Y_Position,'String'));
%         
%         % Current Radial Size
%         cur_radial_size = str2double(get(handles.AOI_Radial_Size,'String'));
%         
%         % Current AOI Color
%         
%         cur_AOI_Color = get(handles.Radial_Contrast_Colors,'Value');
%         
%         switch cur_AOI_Color
%             case 1
%                 set_Color = 'w';
%             case 2
%                 set_Color = 'r';
%             case 3
%                 orange = [1 0.8 0.3];
%                 set_Color = orange;
%             case 4
%                 set_Color = 'y';
%             case 5
%                 set_Color = 'g';
%             case 6
%                 brown = [.7 .5 0];
%                 set_Color = brown;
%             case 7
%                 set_Color ='b';
%                 
%             otherwise    
%                 violet = [0.6 0 1];
%                 set_Color = violet;
%         end
%               
%         
%         
%         
%         % Parametric Equations of AOI
%         t = linspace(0,2*pi,1000);
%         x12 = cur_radial_size*cos(t) + cur_eye_x2;
%         y12 = cur_radial_size*sin(t) + cur_eye_y2;
%         
%         axes(handles.AOI_Axes); 
%         
%         switch current_color2
%             case 1
%                 % White FP
%                 
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','w');
%         
%                 hold off
%                 axis([0 1 0 1])
% 
%             case 2
%                 % Red FP
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','r');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 3
%                 % Orange FP
%                 orange = [1 0.8 0.3];
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',orange);
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 4
%                 % Yellow FP
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','y');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 5
%                 % Green FP
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','g');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 6
%                 % Brown
%                 brown = [.7 .5 0];
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',brown);
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             case 7
%                 % Indigo (Blue)
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color','b');
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%             otherwise
%                 % Violet
%                 violet = [0.6 0 1];
%                 fill(x12,y12,set_Color);
%                 hold on
%        
%                 plot(cur_eye_x2,cur_eye_y2,'x','MarkerSize',15,'Color',violet);
%         
%                 hold off
%                 axis([0 1 0 1])
%                 
%         end
        
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
        
        get_Fixation_PT_X =str2double( get(handles.AOI_X_Position,'String'));
        get_Fixation_PT_Y =str2double( get(handles.AOI_Y_Position,'String'));
        
        switch selectFP_Sym
            case 'FP_Numbers'
                % Numbers
                test = Numbers1{selected_item};
                hold on
                h = plot(get_Fixation_PT_X,get_Fixation_PT_Y,'o');
                set(h, 'Marker',test);
                hold off
                fprintf('%i\n',str2double(test));
            case 'FP_Letters'
                % Letters
                test1 = Letters1{selected_item};
                fprintf('%s\n',test1);    
            otherwise
                % Shapes
                test2 = Shapes1{selected_item};
                fprintf('%s\n',test2);
            
        end
        
        

function Current_FP_ListBox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%----------------- Fixation_Point Contrast : Change Background Image(Push Button)------------------------%
function Fixation_Point_Change_Background_Button_Callback(hObject, eventdata, handles)
          [FileName,PathName] = uigetfile('*.jpg;*.png;*.gif','Select an Fixation Point Background image');
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

function [handles] = Feedback_Signal_Types_Panel_SelectionChangeFcn(hObject, eventdata, handles)
        
        % Initialize Feedback Signal
%         feedback_tone = 'Tone';
%         feedback_click = 'Click';
%         
%         % Gets Selected Feedback Signal
%         selected_feedback_signal = get(eventdata.NewValue,'Tag');
        
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

    global start
    global check

    if(start==1)
        check = 1;  
    else
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
function [handles] = Run_Trial_Button_Callback(hObject, eventdata, handles)
        
        % Experimental Trials Parameters
%         number_trials = str2double(get(handles.Number_Trials,'String'));
%         trial_duration = str2double(get(handles.Trial_Duration,'String'));
%         
%         % Trials Counter
%         
%         global eye_data
%         eye_data = 0;
%         
%         eye_x_position = zeros(1,50);
%         eye_y_position = zeros(1,50);
%         
%         
%         wait = 1;
% 
%         
%         for i = 1:number_trials
%             % Set Current Trial Executing
%             set(handles.Current_Trial_Text,'String',i);
%             
%             % Set Text File Specifications
%             t = 'trial_';
%             s = '.txt';
%             r = num2str(i);
%             trial_txt = strcat(t,r,s);
%             
%             
%              
%             fid = fopen(trial_txt,'w');
%             fprintf(fid,'%6.2f %12.8f\n',y);
%             
%         end
        
        
            
%-----------------Trials: Stop Current Trial (Push Button)------------------------%
function Stop_Current_Trial_Button_Callback(hObject, eventdata, handles)
         
            


%-----------------Trials: Reset Trial (Push Button)------------------------%
function Reset_Trials_Button_Callback(hObject, eventdata, handles)


%-----------------Trials: Stop All Trials (Push Button)------------------------%
function Stop_All_Trials_Button_Callback(hObject, eventdata, handles)







