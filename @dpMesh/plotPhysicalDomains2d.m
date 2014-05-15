%% plotPhysicalDomains2d.m
%
% mesh plotting: display physical domains with separate colors
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plotPhysicalDomains2d(this,varargin)

defaults.colors = {'r','g','b','k','m','y'};
defaults.order = 1;
defaults.tags = sort(this.getElementTags(2));
defaults.faceColor = 'none';
defaults.showTagColors = 1;
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
hold off

this.setDimensionToView();
showTagColors('Physical Domains 2-D',param);
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
        'EdgeColor',param.colors{k},'FaceColor',faceColor);
    hold on
    end
end
end