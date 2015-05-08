function s = setCoordinates(this,coordinates,varargin)
  % Set new chart to object. Returns current chart index.
  %
  % parameters:
  %   - coordinates: coordinates of each node
  %
  % varargin:
  %   - name {''}: name of chart, this can be used to change the chart
  %   - properties {[]}: properties for the chart
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.properties = [];
  defaults.name = '';
  defaults.chartsInd = length(this.charts)+1;
  defaults.chartsActive = defaults.chartsInd;
  
  param = common.setDefaultParameters(defaults,varargin);
  
  this.charts{param.chartsInd}.coords = coordinates;
  this.charts{param.chartsInd}.properties = param.properties;
  this.charts{param.chartsInd}.name = param.name;
  this.chartsActive = param.chartsActive;
  s = param.chartsInd;
end
