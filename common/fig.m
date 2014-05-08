%% fig.m
%
% launch figure whose size is controlled in a nice way
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = fig(varargin) % init figure
defaults.fn = 1; % number for figure
defaults.height = 8;
defaults.width = 8;
defaults.fontSize = 10;
defaults.offsetx = 5;
defaults.offsety = 5;
defaults.axesPosition = 0;
defaults.useLatex = 0;
param = setDefaultParameters(defaults,varargin);
if defaults.fn == 0
    h = nan;
    return
end

size = [param.offsetx param.offsety param.width param.height];
h = figure(param.fn);
set(gcf,'Unit','centimeters',...
    'PaperUnits','centimeters',...
    'position',size,...
    'PaperPosition',size,...
    'PaperType','<custom>');
set(gcf, 'DefaultAxesFontSize', param.fontSize);
set(gcf, 'DefaultTextFontSize', param.fontSize);
if param.useLatex
    set(gcf, 'DefaultTextInterpreter', 'latex');
end
set(gcf, 'paperpositionmode','auto');

if length(param.axesPosition) == 4
    axes('position',param.axesPosition)
end

end
