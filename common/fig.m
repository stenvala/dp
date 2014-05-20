function h = fig(varargin)
% Launch custom figure
%
% varargin:
%   - axesPosition {0}: give custom position for axes with 4-vector
%   - figure {1}: number of figure, if 0 do nothing
%   - fontSize {10}: font-size in figure
%   - height {8}: height of figure in cm
%   - offsetx {5}: difference between figure's left edge and screen
%   - offsety {5}: difference between figure's bottom edge and screen
%   - useLatex {0}: use latex interpreter in layout
%   - width {8}: width of figure in cm
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

defaults.figure = 1;
defaults.height = 8;
defaults.width = 8;
defaults.fontSize = 10;
defaults.offsetx = 5;
defaults.offsety = 5;
defaults.axesPosition = 0;
defaults.useLatex = 0;
param = setDefaultParameters(defaults,varargin);
if param.figure == 0
    h = nan;
    return
end

size = [param.offsetx param.offsety param.width param.height];
h = figure(param.figure);
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
