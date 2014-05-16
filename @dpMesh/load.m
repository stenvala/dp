%% load.m
%
% load project from .mat file
%
% Created: Antti Stenvall (antti@stenvall.fi)

function load(this,varargin)
defaults.fileName = [this.project '.mat'];
param = setDefaultParameters(defaults,varargin);
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
this.gmshPath = gmshPath;
this.reader = reader;
end