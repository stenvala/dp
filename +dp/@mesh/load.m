function load(this,varargin)
  % Initialize object from .mat file.
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fileName = [this.project '.mat'];
  param = common.setDefaultParameters(defaults,varargin);
  project = []; % because project is matlab function
  load(param.fileName);
  
  this.project = project;
  this.geoFile = geoFile;
  this.msh = msh;
  this.charts = charts;
  this.chartsActive = chartsActive;
  this.initdata = initdata;
  this.time = time;
  this.dim = dim;
  %this.gmshPath = gmshPath; % let's not init this here
  this.reader = reader;
end
