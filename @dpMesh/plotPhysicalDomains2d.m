%% plotPhysicalDomains2d.m
%
% plot mesh in 2d, but this time physical domains with separate colors
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plotPhysicalDomains2d(this,varargin)

defaults.colors = {'r','g','b','k','m','y'};
defaults.order = 1;
defaults.tags = sort(unique(this.getElementTags('tri')));
defaults.fileName = this.project;
param = setDefaultParameters(defaults,varargin);

h = fig(varargin{:});

c = this.getCoordinates();
t = this.getElementTopology('tri');
tags = this.getElementTags('tri');
for k=1:length(param.tags)
    if length(param.colors) < k
       param.colors{k} = rand(1,3); 
    end
    trimesh(t(tags == param.tags(k),:),...
        c(:,1),c(:,2),c(:,3),ones(size(c(:,3))),'EdgeColor',param.colors{k});
    hold on
end
hold off

figAdjust(varargin{:});
