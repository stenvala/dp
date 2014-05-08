%% setCoordinates.m
%
% save coordinates of a mesh
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setCoordinates(this,coordinates,varargin)
    defaults.properties = [];
    defaults.chartsInd = length(this.charts)+1;
    defaults.chartsActive = defaults.chartsInd;
    
    param = setDefaultParameters(defaults,varargin);

    this.charts{param.chartsInd}.coords = coordinates;
    this.charts{param.chartsInd}.properties = defaults.properties;
    this.chartsActive = defaults.chartsActive;
end