function h = plotPhysicalDomains2d(this,varargin)
  % Plot 2d elements with separate colors and display in command window.
  %
  % varargin:
  %   - colors {default}: color for edge groups based on tags
  %   - faceAlpha {1}: face transparency
  %   - faceColor {none}: color for faces
  %   - showTagColor {1}: display tag colors in command window
  %   - num {all}: which element numbers to plot
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.colors = getDefaultColors();
  defaults.tags = sort(this.getElementTags(2));
  defaults.faceColor = 'none';
  defaults.showTagColors = 1;
  defaults.faceAlpha = 1;
  defaults.num = nan;
  param = setDefaultParameters(defaults,varargin);
  
  % make colors corresponding to tags
  param.colors = getColorCell(length(param.tags),param.colors);
    
  h = fig(varargin{:});
  c = this.getCoordinates();
  % triangles
  if isfield(this.msh,'tri')
    t = this.getElementTopology('tri');
    tags = this.getElementTags('tri');
    intPlotter(t,1:3,tags,c,param);
  end
  % 2nd order triangles
  if isfield(this.msh,'tri2')
    t = this.getElementTopology('tri2');
    tags = this.getElementTags('tri2');
    intPlotter(t,1:3,tags,c,param);
  end
  % quadrangles
  if isfield(this.msh,'quad')
    t = this.getElementTopology('quad');
    tags = this.getElementTags('quad');
    if ~isnan(param.num)
      ind = ismember(this.msh.quad.nums,param.num);
      t = t(param.num,:);
      tags = tags(param.num,:);
    end          
    intPlotter(t,1:4,tags,c,param);
  end
  hold off
  
  this.setDimensionToView();
  if param.showTagColors
    showTagColors('Physical Domains 2-D',param);
  end
  figAdjust(varargin{:});
end

% internal plotter function
function intPlotter(poly,ind,tags,c,param)  
  x = c(:,1);
  y = c(:,2);
  z = c(:,3);
  for k=1:length(param.tags)
    if strcmp(param.faceColor,'edge')
      faceColor = param.color{k};
    else
      faceColor = param.faceColor;
    end
    p = tags == param.tags(k);
    if any(p)
      nodeInd = poly(p,ind);
      patch(x(nodeInd'),y(nodeInd'),z(nodeInd'),...
        ones(1,size(nodeInd,1)),...
        'faceAlpha',param.faceAlpha,...
        'EdgeColor',param.colors{k},'FaceColor',faceColor);
      hold on
    end
  end
end