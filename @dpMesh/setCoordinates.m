%% setCoordinates.m
%
% save coordinates of a mesh
%
% Created: Antti Stenvall (antti@stenvall.fi)

function s = setCoordinates(this,coordinates,varargin)
    defaults.properties = [];
    defaults.name = '';
    defaults.chartsInd = length(this.charts)+1;
    defaults.chartsActive = defaults.chartsInd;
    
    param = setDefaultParameters(defaults,varargin);

    this.charts{param.chartsInd}.coords = coordinates;
    this.charts{param.chartsInd}.properties = param.properties;
    this.charts{param.chartsInd}.name = param.name;
    this.chartsActive = param.chartsActive;    
    s = param.chartsInd;
end