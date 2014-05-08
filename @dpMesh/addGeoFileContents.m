%% load.m
%
% load project from .mat file
%
% Created: Antti Stenvall (antti@stenvall.fi)

function addGeoFileContents(this,varargin)
defaults.fileName = [this.project '.geo'];
param = setDefaultParameters(defaults,varargin);

this.geoFile.name = param.fileName;
this.geoFile.contents = this.readFile(param.fileName);
end