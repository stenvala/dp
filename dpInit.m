%% dpInit.m
%
% set modules of dp solver to Matlab path
%
% Created: Antti Stenvall (antti@stenvall.fi)

function varargout = dpInit()
  
  now = strrep(mfilename('fullpath'),mfilename,'');
  
  if nargout
    varargout{1} = now;
    return
  end
  
  %% Add modules to Matlab path
  modules = {'',... % for adding the objects and this file
    'common',...
    'pro',...
    'prop/common',...
    };
  
  % Set Modules to path
  newPath = path;
  
  for k=1:length(modules)
    newDir = [now modules{k}];
    if isempty(strfind(newPath,newDir)) % if does not yet exist
      addpath(newDir);
    end
  end
  
  % add to path all the fileExchange tools
  dirs = genpath([now 'fileExchange']);
  addpath(dirs);
  
  disp('Matlab path data changed successfully.')
  disp('Initialization finished.')
end
