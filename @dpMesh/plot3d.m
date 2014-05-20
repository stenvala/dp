function h = plot3d(this,varargin)
  % Plot 2d elements.
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
  defaults.faceColor = 'white';
  defaults.edgeColor = getDefaultColors(1);
  param = setDefaultParameters(defaults,varargin);%,'tetraprops');
  
  h = fig(varargin{:});
  
  c = this.getCoordinates();
  t = this.getElementTopology('tet');
  tetramesh(t,c,...
    'edgeColor',param.edgeColor,...
    'faceColor',param.faceColor,...
    'faceAlpha',param.faceAlpha);
  
  figAdjust(varargin{:});
  
end
