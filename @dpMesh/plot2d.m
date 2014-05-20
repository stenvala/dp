function h = plot2d(this,varargin)
  % Plot 2d elements.
  %
  % varargin:
  %   - edgeColor {default1}: color for edges
  %   - faceColor {none}: color for faces
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if this.dim == 2
    defaults.view = [0 90];
  end
  
  defaults.faceColor = 'none';
  defaults.edgeColor = getDefaultColors(1);
  param = setDefaultParameters(defaults,varargin);
  
  h = fig(varargin{:});
  c = this.getCoordinates();
  
  params = {'edgeColor',param.edgeColor,...
    'faceColor',param.faceColor};
  
  if isfield(this.msh,'tri')
    t = this.getElementTopology('tri');
    trimesh(t,c(:,1),c(:,2),c(:,3),params{:});
    hold on
  end
  
  if isfield(this.msh,'tri2')
    t = this.getElementTopology('tri2');
    trimesh(t(:,[1 2 3]),c(:,1),c(:,2),c(:,3),params{:});
    hold on
  end
  hold off
  view(defaults.view);
  figAdjust(varargin{:});
  
end

