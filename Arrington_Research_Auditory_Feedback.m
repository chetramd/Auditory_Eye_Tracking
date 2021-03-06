%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Arrington Research - Auditory Feedback using a Eye Tracker
%   
%   Created and Developed By: Chetram Dasrat and Michael Iannelli
%
%   Senior Design Project - Spring 2013 to Fall 2013 
%   Computer Engineering
%
%   The City College of New York - Department of Computer Science
%   Advisor: Professor Izidor Gertner
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


function Arrington_Research_Auditory_Feedback_OpeningFcn(hObject, eventdata, handles, varargin)

try
    clc;

    %% Loading dynamically linked library from Viewpoint
    dll_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\VPX_InterApp.dll';
    sdk_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\SDK\';
    header_location = strcat(sdk_location,'vpx.h');
    toolbox_location = strcat(sdk_location,'vptoolbox.h');
    
    vpx_Initialize(dll_location,header_location,toolbox_location);
    
    %% Initialize Variables
    
    % Start variables
    global start
    start = 0;
    
    % Generate Handles Output
    handles.output = hObject;
    
    % Generate GUI using hObjects
    guidata(hObject, handles);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    time=1:50;
    eye_x_position = zeros(1,50);
    eye_y_position = zeros(1,50);
    axes(handles.axes2);
    hLine=plot(time,eye_x_position);ylim([0 1]);
    
    %stripchart('Initialize',h)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Set Axes on AOI Axes
    axes(handles.AOI_Axes);
    
    %% Retrieve Eye Information from Viewpoint
    global eye_data
    eye_data = 0;

    global check
    check = 0;

    count = 1;
    test = 0;
    differ = 0;
    
    while(check ~= 1)

        %% AREA OF INTEREST
        
        % Get X and Y Gaze Positions from Viewpoint
        gaze_Positions=struct('x',0.5,'y',0.5); 
        [gaze_Positions.x,gaze_Positions.y] = vpx_GetGazePointSmoothed(eye_data);
        
        % Get Iteration from Gaze Positions
        eye_x_position(count)= gaze_Positions.x;
        eye_y_position(count)= gaze_Positions.y;

        stripchart('Update',hLine,eye_x_position(count));
        
        % Get Handles from Functions
        handles  = AOI_Set_Fixation_Radial_Size_Button_Callback(handles.AOI_Set_Fixation_Radial_Size_Button,eventdata,handles);
        handles1 = Radial_Contrast_Colors_Callback(handles.Radial_Contrast_Colors,eventdata,handles);
        handles2 = Fixation_Point_Contrast_Colors_Callback(handles.Fixation_Point_Contrast_Colors,eventdata,handles);
        handles3 = Feedback_Signal_Types_Panel_SelectionChangeFcn(handles.Feedback_Signal_Types_Panel,eventdata,handles);
        handles4 = Radial_Contrast_Lum_Slider_Callback(handles.Radial_Contrast_Lum_Slider,eventdata,handles);
        handles5 = Current_Feedback_Freq_Text_Callback(handles.Current_Feedback_Freq_Text, eventdata, handles);
        handles6 = Run_Trials_Button_Callback(handles.Run_Trials_Button, eventdata,handles);
        handles7 = Data_Filename_Edit_Text_Callback(handles.Data_Filename_Edit_Text,eventdata,handles);
        handles8 = Number_Trials_Callback(handles.Number_Trials,eventdata,handles);
        handles9 = Trial_Duration_Callback(handles.Trial_Duration, eventdata, handles);
		
		
        
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
        
        % Distance from Center of Circle to Point
        distance_Center_to_Point_X = str2double(fp_x_position) - eye_x_position(count);
        distance_Center_to_Point_Y = str2double(fp_y_position) - eye_y_position(count);
        
         % Length from Center to Point
        length_Center_to_Point = sqrt((distance_Center_to_Point_X).^2 +(distance_Center_to_Point_Y).^2);
                
        switch select_Tag
            case 'Feedback_Signal_Tone'
                Fs = 1000;
                nSeconds = .3;
				%Create frequency inversely proportional to distance from Point
                frequency = (1000/length_Center_to_Point);
				%Generate tone of aforementioned frequency
                y = 100*sin(linspace(0,nSeconds*frequency*2*pi,round(nSeconds*Fs)));
				%Play Tone Aduio
                sound(y,Fs)
				%fprintf('%d\n',frequency)
                freq1 = strcat(num2str(round(frequency )),' Hz');
                set(handles.Current_Feedback_Freq_Text,'String',freq1);
            otherwise
                % Feedback Signal: Click
                % Point Circle Collision Detection
                nofreq = 'N/A';
                set(handles.Current_Feedback_Freq_Text,'String',nofreq);
                
                radius_fp = str2double(fp_radius);
                              
                %Set new Position
                newPosition = get(handles.Eye_Position_Area_Interest_Text,'String');
                
                %Declare old position as global variable
                global oldPosition
                
                %Compare New Position against old position 
                %if location of old position is different from new position
                %with respect to the location within roi, output a "click"
                if(newPosition(1) ~= oldPosition(1))
                    [y,Fs] = wavread('click_sound.wav');
                    fprintf('%s\n','Click');
                    sound(y,Fs);
                end
                
                %Shift new Position to old Position
                oldPosition = newPosition;
        end
        
        
        
        %% Experimental Trials
        
        run_trials = get(handles6.Run_Trials_Button,'Value');
        
        
        %num_trials2 = str2num(get(handles8.Number_Trials,'String'));
            
        %trial_duration2 = str2num(get(handles9.Trial_Duration,'String'));
            
        %datafname2 = get(handles7.Data_Filename_Edit_Text,'String');
        
        if(run_trials == 1)
            
            num_trials = str2num(get(handles8.Number_Trials,'String'));
            
            trial_duration = str2num(get(handles9.Trial_Duration,'String'));
            
            datafname = get(handles7.Data_Filename_Edit_Text,'String');
            
            %num_trials = 5;
            
            %trial_duration = 10;
            % Data Filename
            
            %datafname = 'test';
            
            %datafname = 'test';
            dat = '.dat';
            fName = strcat(datafname,dat);
            
            %fName = 'results.txt';
            fid = fopen(fName,'a+');
    
            fprintf(fid,'Trial #    Time Entry    X-Eye Position    Y-Eye Position     Inside Area of Interest \r\r\n');
            
            h = waitbar(0,'1','Name','Running trials...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
            setappdata(h,'canceling',0)
            
            for i = 1: num_trials
                if getappdata(h,'canceling')
                    break;
                end
                    
                waitbar(i/num_trials,h,sprintf('Executing Trial # %i / %i',i,num_trials));
                    
                t_start = tic;
                    
                while(toc(t_start) <= trial_duration) &&(check ~= 1)
                    % Get X and Y Gaze Positions from Viewpoint
                    gaze_Positions=struct('x',0.5,'y',0.5); 
                    [gaze_Positions.x,gaze_Positions.y] = vpx_GetGazePointSmoothed(eye_data);
        
                    % Get Iteration from Gaze Positions
                    eye_x_position(count)= gaze_Positions.x;
                    eye_y_position(count)= gaze_Positions.y;
            
                    % Time Entry
                    dt = datestr(now,'HH:MM:SS AM');
                
                    % Inside AOI:
            
                    % Gaze Point x
                    x2 = eye_x_position(count);
                    % Gaze Point y
                    y2 = eye_y_position(count);
                    % Fixation Pt x
                    x1 = fp_x_position;
                    % Fixation Pt y
                    y1 = fp_y_position;
 
                    % Distance from AOI to Current Fixation Pt
                    distance = sqrt(((x2-x1)^2)+(y2-y1)^2);
            
                    if(distance <= fp_radius)
                       % Yes
                        insideAOI = 1;
                    else
                       % No
                        insideAOI = 0;
                    end
            
                    % Write to FID
                    % Parameters
            
                    % Trial #: i;
                    % Time Entry: dt
                    % X-Eye Position: eye_x_position(count);
                    % Y-Eye Position: eye_y_position(count);
                    % Inside AOI:insideAOI
            
                    fprintf(fid,'  %i       %s    %i      %i             %i  \r\n',i,dt,eye_x_position(count),eye_y_position(count),insideAOI);
    
                    count = count +1;
                end     
            end
            delete(h)
        
            fclose(fid);
   
            % Move File to Directory DATA
            datadir= 'DATA';
    
            [s, mess, messid] = mkdir('DATA'); %#ok<NASGU>
            if(isequal(exist(datadir,'dir'),7))
                % Directory exists then Move dat file into Data
                movefile(fName,'DATA','f'); 
            else
                % Make Directory
                [s, mess, messid] = mkdir('DATA'); %#ok<ASGLU>
                if(s==1) % correcty made directory
                    % Move dat file int DATA
                    movefile(fName,'DATA','f');
                else
                    fprintf('Cannot create DATA directory');
                end
            end
            
            % Reset ToggleButton
            set(handles.Run_Trials_Button,'Value',0);
        end
            
            
       
        
        
        
        
        %%  
        count = count +1;
        start = 1;
    end
    delete(hObject);
    
catch err
 
end

% --- Outputs from this function are returned to the command line.
function varargout = Arrington_Research_Auditory_Feedback_OutputFcn(hObject, eventdata, handles) 

    global check
     if(check == 0)
         %varargout{1} = handles.output;  
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

function [handles] = Current_Feedback_Freq_Text_Callback(hObject, eventdata, handles) 
		


%-----------------Auditory Feedback: Select Feedback Signal Type (Button Group)------------------------%
function Feedback_Signal_Types_Panel_CreateFcn(hObject, eventdata, handles)

function [handles] = Feedback_Signal_Types_Panel_SelectionChangeFcn(hObject, eventdata, handles)
        
        
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

%-----------------Trials: Data File Name(Edit Text)------------------------%
function [handles] = Data_Filename_Edit_Text_Callback(hObject, eventdata, handles)

function Data_Filename_Edit_Text_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----------------Trials: Number of Trials (Edit Text)------------------------%
function [handles] = Number_Trials_Callback(hObject, eventdata, handles)
        
function Number_Trials_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-----------------Trials: Trial Duration (seconds) (Edit Text)------------------------%
function [handles] = Trial_Duration_Callback(hObject, eventdata, handles)

function Trial_Duration_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Run_Trials_Button_CreateFcn(hObject, eventdata, handles)

%-----------------Trials: Run Trial (Push Button)------------------------%
function [handles] = Run_Trials_Button_Callback(hObject, eventdata, handles)

%          test = get(handles.Run_Trials_Button,'Value');
%          fprintf('Handles Fun : %i\n',test);
         
        
          
          
        
            
%-----------------Trials: Stop Trials (Push Button)------------------------%
function [handles] = Stop_Trials_Button_Callback(hObject, eventdata, handles)
         
%-----------------Trials: Reset Trial (Push Button)------------------------%
function Reset_Trials_Button_Callback(hObject, eventdata, handles)
            % Resets Data Filename, Number of Trials, Trial Duration,
            % Current Trial
            set(handles.Data_Filename_Edit_Text,'String','Enter Data Filename');
            set(handles.Number_Trials,'String','0');
            set(handles.Trial_Duration,'String','0');
            set(handles.Current_Trial_Text,'String','0');
            






