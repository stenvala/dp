function make(this,varargin)
  % Generate mesh with gmsh, windows version.
  %
  % parameters:
  %   - directory {working dir}: where the file is
  %   - fileName {this.project}: .geo/.msh file for input/output
  %   - order {1}: order of elements to be created
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.directory = pwd;
  defaults.order = 1;
  defaults.fileName = this.project;
  param = common.setDefaultParameters(defaults,varargin);
  
  tic
  dos(['"' this.gmshPath '" ' ...
    '"' fullfile(param.directory,param.fileName) '.geo" ' ...
    '-' num2str(this.dim) ' -order ' num2str(param.order) ' -o ' ...
    '"' fullfile(param.directory,param.fileName) '.msh"']);
  this.time.makeMesh = toc;
  
end
