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
  %   - see for more: help fig, help common.figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.colors = common.getDefaultColors();
  defaults.tags = sort(this.getElementTags(2));
  defaults.faceColor = 'none';
  defaults.showTagColors = 1;
  defaults.faceAlpha = 1;
  defaults.num = nan;
  param = common.setDefaultParameters(defaults,varargin);
  
  % make colors corresponding to tags
  param.colors = common.getColorCell(length(param.tags),param.colors);
  
  h = common.fig(varargin{:});
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
  % 3rd order triangles
  if isfield(this.msh,'tri3')
    t = this.getElementTopology('tri3');
    tags = this.getElementTags('tri3');
    intPlotter(t,1:3,tags,c,param);
  end
  % 4thorder triangles
  if isfield(this.msh,'tri4')
    t = this.getElementTopology('tri4');
    tags = this.getElementTags('tri4');
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
    common.showTagColors('Physical Domains 2-D',param);
  end
  common.figAdjust(varargin{:});
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
      if size(faceColor,1) > 1
        size(faceColor)
        size(x(nodeInd'))
        patch(x(nodeInd'),y(nodeInd'),z(nodeInd'),...
          faceColor,...
          'faceAlpha',param.faceAlpha,...
          'EdgeColor','none');        
      else
        patch(x(nodeInd'),y(nodeInd'),z(nodeInd'),...
          ones(1,size(nodeInd,1)),...
          'faceAlpha',param.faceAlpha,...
          'EdgeColor',param.colors{k},'FaceColor',faceColor);
      end
      hold on
    end
  end
end