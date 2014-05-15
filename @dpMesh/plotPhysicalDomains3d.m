%% plotPhysicalDomains3d.m
%
% mesh plotting: display physical domains with separate colors
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plotPhysicalDomains3d(this,varargin)

defaults.colors = {'r','g','b','k','m','y'};
defaults.order = 1;
defaults.tags = sort(unique(this.getElementTags('tet')));
defaults.faceAlpha = 0.5;
defaults.edgeColor = 'k';
defaults.showTagColors = 1;
param = setDefaultParameters(defaults,varargin);

param.colors = getColorCell(length(param.tags),param.colors);

h = fig(varargin{:});

c = this.getCoordinates();
t = this.getElementTopology('tet');
tags = this.getElementTags('tet');
for k=1:length(param.tags)
    tetramesh(t(tags == param.tags(k),:),c,...
        'EdgeColor',param.edgeColor,'faceColor',param.colors{k},'faceAlpha',param.faceAlpha);
    hold on
end
hold off

this.setDimensionToView();
showTagColors('Physical Domains 3-D',param);

figAdjust(varargin{:});

%% TODO: support all element shapes 