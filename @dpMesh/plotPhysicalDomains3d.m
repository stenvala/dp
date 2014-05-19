function h = plotPhysicalDomains3d(this,varargin)
% Plot 3d elements with separate colors and display in command window.
%
% varargin:
%   - colors {default}: color for edge groups based on tags
%   - edgeColor {k}: color for edges of elements
%   - faceAlpha {0.5}: color for faces
%   - showTagColor {1}: display tag colors in command window
%   - tags {all tet}: define which tags to plot
%
%   - see for more: help fig, help figAdjust
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

defaults.colors = getDefaultColors();
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
end
