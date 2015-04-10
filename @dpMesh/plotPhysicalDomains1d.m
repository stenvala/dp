function h = plotPhysicalDomains1d(this,varargin)
  % Plot 1d elements with separate colors and display in command window.
  %
  % varargin:
  %   - colors {default}: color for edge groups based on tags
  %   - edgeColor {default1}: color for edges
  %   - lineWidth {1}: line width
  %   - showTagColor {1}: display tag colors in command window
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.colors = getDefaultColors();
  defaults.tags = sort(this.getElementTags(1));
  defaults.lineWidth = 1;
  defaults.marker = '';
  defaults.showTagColors = 1;
  param = setDefaultParameters(defaults,varargin);
  
  % make colors corresponding to tags
  param.colors = getColorCell(length(param.tags),param.colors);
  
  h = fig(varargin{:});
  c = this.getCoordinates();
  x = c(:,1);
  y = c(:,2);
  z = c(:,3);
  % edges
  if isfield(this.msh,'edg')
    t = this.getElementTopology('edg');
    tags = this.getElementTags('edg');
    intPlotter(x(t),y(t),z(t),tags,param);
  end
  % 2nd order edges
  if isfield(this.msh,'edg2')
    t = this.getElementTopology('edg2');
    tags = this.getElementTags('edg2');
    intPlotter(x(t(:,1:2)),y(t(:,1:2)),z(t(:,1:2)),tags,param);
  end
  % 3nd order edges
  if isfield(this.msh,'edg3')
    t = this.getElementTopology('edg3');
    tags = this.getElementTags('edg3');
    intPlotter(x(t(:,1:2)),y(t(:,1:2)),z(t(:,1:2)),tags,param);
  end
  % 4th order edges
  if isfield(this.msh,'edg4')
    t = this.getElementTopology('edg4');
    tags = this.getElementTags('edg4');
    intPlotter(x(t(:,1:2)),y(t(:,1:2)),z(t(:,1:2)),tags,param);
  end
  hold off
  
  this.setDimensionToView();
  showTagColors('Physical Domains 1-D',param);
  figAdjust(varargin{:});
end

% internal plotter function
function intPlotter(x,y,z,tags,param)
  for k=1:length(param.tags)
    inds = find(tags == param.tags(k));    
    props = {'color',param.colors{k},...
        'lineWidth',param.lineWidth};
    if ~strcmp(param.marker,'')
      props{end+1} = 'marker';
      props{end+1} = param.marker;
    end    
    for p=inds'                  
      plot3(x(p,:),y(p,:),z(p,:),props{:});
      hold on
    end
  end
end