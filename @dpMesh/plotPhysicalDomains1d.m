%% plotPhysicalDomains1d.m
%
% mesh plotting: display physical domains with separate colors
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plotPhysicalDomains1d(this,varargin)

defaults.colors = {'r','g','b','k','m','y'};
defaults.order = 1;
defaults.tags = sort(this.getElementTags(1));
defaults.lineWidth = 1;
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
hold off

this.setDimensionToView();
showTagColors('Physical Domains 1-D',param);
figAdjust(varargin{:});
end

% internal plotter function
function intPlotter(x,y,z,tags,param)
for k=1:length(param.tags)    
    inds = find(tags == param.tags(k));
    for p=inds'        
        plot3(x(p,:),y(p,:),z(p,:),...
        'color',param.colors{k},...
        'lineWidth',param.lineWidth);
    hold on
    end
end
end