function h = plotPhysicalDomains0d(this,varargin)
  % Plot 0d elements with separate colors and display in command window.
  %
  % varargin:
  %   - colors {default}: color for vertices  
  %   - showTagColor {1}: display tag colors in command window
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.colors = getDefaultColors();
  defaults.marker = 'o';
  defaults.lineWidth = 2;
  defaults.tags = sort(this.getElementTags(0));
  defaults.markerSize = 10;
  defaults.showTagColors = 1;
  param = setDefaultParameters(defaults,varargin);
  
  % make colors corresponding to tags
  param.colors = getColorCell(length(param.tags),param.colors);
  
  h = fig(varargin{:});
  c = this.getCoordinates();
  x = c(:,1);
  y = c(:,2);
  z = c(:,3);
  
  % plot vertices
  if isfield(this.msh,'vtx')
    t = this.getElementTopology('vtx');
    tags = this.getElementTags('vtx');
    intPlotter(x(t),y(t),z(t),tags,param);
  end  
  hold off
  
  this.setDimensionToView();
  showTagColors('Physical Domains 0-D',param);
  figAdjust(varargin{:});
end

% internal plotter function
function intPlotter(x,y,z,tags,param)
  for k=1:length(param.tags)
    inds = find(tags == param.tags(k));        
    for p=inds'      
      plot3(x(p,:),y(p,:),z(p,:),...
        'marker',param.marker,...
        'color',param.colors{k},...
        'linewidth',param.lineWidth,...
        'markerSize',param.markerSize);      
      hold on
    end
  end
end