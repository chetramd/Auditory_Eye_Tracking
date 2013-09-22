function varargout = Experimental_Trials(varargin)
% EXPERIMENTAL_TRIALS MATLAB code for Experimental_Trials.fig
%      EXPERIMENTAL_TRIALS, by itself, creates a new EXPERIMENTAL_TRIALS or raises the existing
%      singleton*.
%
%      H = EXPERIMENTAL_TRIALS returns the handle to a new EXPERIMENTAL_TRIALS or the handle to
%      the existing singleton*.
%
%      EXPERIMENTAL_TRIALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTAL_TRIALS.M with the given input arguments.
%
%      EXPERIMENTAL_TRIALS('Property','Value',...) creates a new EXPERIMENTAL_TRIALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experimental_Trials_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experimental_Trials_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experimental_Trials

% Last Modified by GUIDE v2.5 17-Jul-2013 15:41:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experimental_Trials_OpeningFcn, ...
                   'gui_OutputFcn',  @Experimental_Trials_OutputFcn, ...
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


% --- Executes just before Experimental_Trials is made visible.
function Experimental_Trials_OpeningFcn(hObject, eventdata, handles, varargin)

    clc;
    %clear all;
    
    dll_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\VPX_InterApp.dll';
    sdk_location = 'C:\Users\Chetram_Michael\Desktop\ViewPoint 2.9.2.5\SDK\';
    header_location = strcat(sdk_location,'vpx.h');
    toolbox_location = strcat(sdk_location,'vptoolbox.h');
    
    vpx_Initialize(dll_location,header_location,toolbox_location);
    
    %% Initialize Variables
    
    % Global Start variables
    global start
    start = 0;
    
    % Generate Handles Output
    handles.output = hObject;
    
    % Generate GUI using hObjects
    guidata(hObject, handles);
    
    % Initialize Eye Position Zeros 
    eye_x_position = zeros(1,50);
    eye_y_position = zeros(1,50);
    
    
    % Get parameters from Main GUI
%     fp_x_position = cell2mat(varargin(1));
%     fp_y_position = cell2mat(varargin(2));
%     fp_radius = cell2mat(varargin(3));
    fp_x_position = 0.5;
    fp_y_position = 0.5;
    fp_radius = 0.2;
    
    %% Retrieve Eye Information from Viewpoint
    global eye_data
    eye_data = 0;

    global check
    check = 0;

    % Iteration
    count = 1;
%     num_trials = cell2mat(varargin(4));
%     
%     trial_duration = cell2mat(varargin(5));
%     
    num_trials = 5;
    trial_duration = 10;
    % Data Filename
%     datafname = cell2mat(varargin(6));
    datafname = 'test';
    dat = '.dat';
    fName = strcat(datafname,dat);
    
    
    
    %fName = 'results.txt';
    fid = fopen(fName,'a+');
    
    fprintf(fid,'Trial #    Time Entry    X-Eye Position    Y-Eye Position     Inside Area of Interest \r\r\n');
    
    for i = 1: num_trials
        fprintf('Starting Trial %i\n', i);
        
        set(handles.Current_Trial_Text,'String',num2str(i+1));
        
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
            start = 1;
        end
        fprintf('Ending Trial %i\n', i);
    end
    
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
    
            



% --- Outputs from this function are returned to the command line.
function varargout = Experimental_Trials_OutputFcn(hObject, eventdata, handles) 
    global check
    if(check == 0)
        varargout{1} = handles.output;  
    end
