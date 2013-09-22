function [xposition, yposition]=vpx_GetGazePointSmoothed(eyetype)

%----------------------------------------------------------------------
%% vpx_GetGazePointSmoothed
%
%   Retrieves the calculated position of gaze
%
%   USAGE: [xposition,yposition]=vpx_GetGazePointSmoothed();
%   INPUT: eyetype (0 for Eye_A and 1 for Eye_B)
%   OUTPUT: x and y position of gaze.
%
%   ViewPoint EyeTracker Toolbox (TM)
%   Copyright 2005-2010, Arrington Research, Inc.
%   All rights reserved.
%----------------------------------------------------------------------

   vpxrealpoint=struct('x',0,'y',0);
   vpstruct = libstruct('VPX_RealPoint', vpxrealpoint);
   if(nargin<1)
       eyetype=0;
   [eye,gazePoint]=calllib('vpx','VPX_GetGazePointSmoothed2',eyetype,vpstruct);
   elseif(nargin==1)
          [null,gazePoint]=calllib('vpx','VPX_GetGazePointSmoothed2',eyetype,vpstruct);
   end
   xposition=gazePoint.x;
   yposition=gazePoint.y;