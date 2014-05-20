function h = plotPhysicalDomains3d(this,varargin)
  % Plot 3d elements with separate colors and display in command window.
  %
  % varargin:
  %   - colors {default}: color for edge groups based on tags
  %   - edgeColor {k}: color for edges of elements
  %   - faceAlpha {0.5}: color for faces
  %   - showTagColor {1}: display tag colors in command window
  %   - tags {all tags}: define which tags to plot (string or cell)
  %   - types {all types}: define which element types to plot
  %
  %   - see for more: help fig, help figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.colors = getDefaultColors();
  defaults.tags = sort(this.getElementTags(3));
  defaults.types = cellfun(@(x) x.name, this.reader,'UniformOutput',false);
  defaults.faceAlpha = 0.5;
  defaults.edgeColor = 'k';
  defaults.showTagColors = 1;
  param = setDefaultParameters(defaults,varargin);
  param.colors = getColorCell(length(param.tags),param.colors);
  if ~iscell(param.types)
    param.types = {param.types};
  end  
   
  h = fig(varargin{:});
  
  c = this.getCoordinates();
  
  % present problem is that internal faces are plotted twice
  
  % tetrahedra
  if isfield(this.msh,'tet') && any(strcmp(param.types,'tet')) 
    t = this.getElementTopology('tet');
    tags = this.getElementTags('tet');
    p1 = sparse(1:4,[1 2 3 1],[1 1 1 0]);
    p2 = sparse(1:4,[1 2 1 3],[1 1 0 1]);
    p3 = sparse(1:4,[1 1 2 3],[1 0 1 1]);
    p4 = sparse(1:4,[1 1 2 3],[0 1 1 1]);
    intPlotter(t,{p1,p2,p3,p4},tags,c,param);
    hold on
  end
  % hexahedra
  if isfield(this.msh,'hex') && any(strcmp(param.types,'hex'))
    t = this.getElementTopology('hex');
    tags = this.getElementTags('hex');
    p1 = sparse(1:8,[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);
    p2 = sparse([5 6 7 8 1 2 3 4],[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);
    p3 = sparse([1 2 6 5 3 4 7 8],[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);
    p4 = sparse([3 4 8 7 1 2 5 6],[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);
    p5 = sparse([2 3 7 6 1 4 5 8],[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);
    p6 = sparse([1 4 8 5 2 3 6 7],[1:4 ones(1,4)],[ones(1,4) zeros(1,4)]);    
    intPlotter(t,{p1,p2,p3,p4,p5,p6},tags,c,param);
    hold on
  end
  % pyramids
  if isfield(this.msh,'pyr') && any(strcmp(param.types,'pyr'))
    t = this.getElementTopology('pyr');
    tags = this.getElementTags('pyr');
    p1 = sparse(1:5,[1:4 1],[ones(1,4) 0]);    
    p2 = sparse([2 3 5 1 4],[1:3 1 1],[ones(1,3) 0 0]);      
    p3 = sparse([4 3 5 2 4],[1:3 1 1],[ones(1,3) 0 0]);      
    p4 = sparse([1 2 5 3 4],[1:3 1 1],[ones(1,3) 0 0]);      
    p5 = sparse([1 4 5 2 3],[1:3 1 1],[ones(1,3) 0 0]);      
    intPlotter(t,{p1,p2,p3,p4,p5},tags,c,param);    
    hold on
  end
   
  hold off
    
  this.setDimensionToView();
  if param.showTagColors
    showTagColors('Physical Domains 3-D',param);
  end
  
  figAdjust(varargin{:});
  
end

% internal plotter function
function intPlotter(poly,faceMatrices,tags,c,param)
  x = c(:,1);
  y = c(:,2);
  z = c(:,3);
  for k=1:length(param.tags)
    if strcmp(param.edgeColor,'face')
      edgeColor = param.color{k};
    else
      edgeColor = param.edgeColor;
    end
    p = tags == param.tags(k);
    if any(p)
      for n=1:length(faceMatrices)
        nodeInd = poly(p,:)*faceMatrices{n};        
        patch(x(nodeInd'),y(nodeInd'),z(nodeInd'),...
          ones(1,size(nodeInd,1)),...
          'faceAlpha',param.faceAlpha,...
          'faceColor',param.colors{k},...
          'edgeColor',edgeColor);
        hold on
      end
    end
  end
end