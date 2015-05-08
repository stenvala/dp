function this = constructor(this,varargin)
  % Constructor for dpMesh instance.
  %
  % See properties at class definition.
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.project = '';
  defaults.dim = 2;
  defaults.description = '';
  defaults.title = '';
  param = common.setDefaultParameters(defaults,varargin);
  this.project = param.project;
  this.dim = param.dim;
  this.initdata.time = clock;
  this.initdata.date = date;
  this.initdata.description = param.description;
  this.initdata.title = param.title;
  this.charts = {};
  this.chartsActive = 0;
  workingDir = dpInit(); % dpInit needs to be in Matlab path
  this.gmshPath = [workingDir 'gmsh\gmsh.exe']; % this works now only in Windows
  % init mesh reader properties
  this.setInitReaderProperties();
end
