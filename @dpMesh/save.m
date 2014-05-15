%% save.m
%
% save project to .mat file
%
% Created: Antti Stenvall (antti@stenvall.fi)

function save(this,varargin)

defaults.fileName = [this.project '.mat'];
param = setDefaultParameters(defaults,varargin);

project = this.project;
geoFile = this.geoFile;
msh = this.msh;
charts = this.charts;
chartsActive = this.chartsActive;
initdata = this.initdata;
time = this.time;
dim = this.dim;
gmshPath = this.gmshPath;
reader = this.reader;
save(param.fileName,'project','geoFile','msh','charts','chartsActive','initdata','time','dim','gmshPath','reader');

end