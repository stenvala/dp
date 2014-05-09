%% plotPhysicalDomains2d.m
%
% mesh plotting: display physical domains with separate colors
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plotPhysicalDomains2d(this,varargin)

defaults.colors = {'r','g','b','k','m','y'};
defaults.order = 1;
defaults.tags = sort(unique(this.getElementTags('tri')));
defaults.fileName = this.project;
defaults.faceColor = 'none';
param = setDefaultParameters(defaults,varargin);

h = fig(varargin{:});

c = this.getCoordinates();
t = this.getElementTopology('tri');
tags = this.getElementTags('tri');
for k=1:length(param.tags)
    if length(param.colors) < k
       param.colors{k} = rand(1,3); 
    end
    if strcmp(param.faceColor,'edge')
       faceColor = param.color{k}; 
    else
        faceColor = param.faceColor;
    end
    
    trimesh(t(tags == param.tags(k),:),...
        c(:,1),c(:,2),c(:,3),ones(size(c(:,3))),...
        'EdgeColor',param.colors{k},'FaceColor',faceColor);
    hold on
end
hold off

figAdjust(varargin{:});
