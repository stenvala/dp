function varargout = dpInit(reset)
  % Initializes paths for dp
  %
  % This function initializes paths to all the objects and utilities in dp.
  % It also resets the path to factury defaults if reset option is not set
  % to false. If output argument is required, nothin is done, but only the
  % path of this file is returned.
  %
  % return values:
  %  - varargout{1}: path to the root directory. This can be used to call
  %                  gmsh
  %
  % parameters:
  %  - rest {1}: reset Matlab path to factory defaults before
  %              initialization.
  %  
  % Created: Antti Stenvall (antti@stenvall.fi)  
  %
  
  now = strrep(mfilename('fullpath'),mfilename,'');
  if nargout
    varargout{1} = now;
    return
  end
  
  if nargin < 1
    reset = 1;
  end
  
  if reset
    restoredefaultpath();
  end    
  
  %% Add modules to Matlab path
  modules = {'',... % for adding the packages
    };
  
  % Set Modules to path
  newPath = path;
  
  for k=1:length(modules)
    newDir = [now modules{k}];
    if isempty(strfind(newPath,newDir)) % if does not yet exist
      addpath(newDir);
    end
  end
  
  % add to path all the fileExchange tools recursively
  dirs = genpath([now 'fileExchange']);
  addpath(dirs);
  
  disp('Matlab path data changed successfully.')
  disp('Initialization finished.')
end
