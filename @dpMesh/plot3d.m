function h = plot3d(this,varargin)
  % Plot 3d elements.
  %
  % varargin:
  %   - edgeColor {default1}: color for edges
  %   - faceAlpha {0.5}
  %   - faceColor {white}: color for faces
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.faceAlpha = 0.5;
  defaults.colors = getDefaultColors(1);
  defaults.edgeColor = 'white';    
  param = setDefaultParameters(defaults,varargin);
  param.showTagColors = 0;
  c = struct2fullcell(param);
  h = this.plotPhysicalDomains3d(c{:});
end
