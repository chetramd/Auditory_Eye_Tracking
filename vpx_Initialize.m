function r = vpx_Initialize( vpxDL, vpToolbox, vpxH )
%------------------------------------------------------
%% vpx_Initialize
%   
%	Loads the dynamically linked library into Matlab.
%
%   USAGE 
%		vpx_Initialize
%
%   IMPORTANT: 
%		You must specify the the full path file name for:
%				vpxDL
%				vpToolbox
%				vpxH
%		Note the paths should be within single quotes.
%
%   USAGE: vpx_Initialize( vpxDL, vpToolbox, vpxH )
%   
%   ViewPoint EyeTracker Toolbox (TM)
%   Copyright 2005-2010, Arrington Research, Inc.
%   All rights reserved.
%------------------------------------------------------
if(libisloaded('vpx')==0)
    if(nargin<1)
        vpxDL     = '\InstallPath\ViewPoint\VPX_InterApp.dll'
        thePath   = '\InstallPath\ViewPoint\SDK\';
        vpToolbox = strcat(thePath,'vptoolbox.h');
        vpxH  	  = strcat(thePath,'vpx.h');
        [notfound,warnings]=loadlibrary( vpxDL, vpToolbox, 'addheader', vpxH, 'alias', 'vpx' );
    elseif(nargin==3)
        loadlibrary( vpxDL, vpToolbox, 'addheader', vpxH, 'alias', 'vpx' );
    end

    warning('off','MATLAB:dispatcher:InexactMatch')
end