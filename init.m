%% DPinit.m
%
% For initializing the discrete problem software platform

function varargout = DPinit()
now = strrep(mfilename('fullpath'),mfilename,'');

if nargout
    varargout{1} = now;
    return
end

%% Add modules to Matlab path
Modules = {'',... % for adding the objects and this file
    'general',...
    };

% Set Modules to path
NewPath = path;

for k=1:length(Modules)
    NewDir = [now Modules{k}];
    if isempty(strfind(NewPath,NewDir)) % if does not yet exist
        NewPath = [NewPath ';' NewDir];
    end
end
NewPath = [NewPath ';'];

% Set path
path(NewPath);

disp('Matlab path data changed successfully.')
disp('Initialization finished.')