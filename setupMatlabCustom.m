function setupMatlabCustom(varargin)
%SETUPLIBMATLAB Add the different directories of LIBMATLAB to the path
%
%   Usage:
%   setupLibMatlab;
%
%   Example
%   setupLibMatlab;
%


% extract library path
fileName = mfilename('fullpath');
libDir = fileparts(fileName);

moduleNames = {...
    'getkey_FileExchange', ...
    'quaternion_FileExchange', ...
    };

disp('Installing MatlabCustom Library');
addpath(libDir);

% add all library modules
for i = 1:length(moduleNames)
    name = moduleNames{i};
    fprintf('Adding module: %-20s', name);
    addpath(fullfile(libDir, name));
    disp(' (ok)');
end
savepath

