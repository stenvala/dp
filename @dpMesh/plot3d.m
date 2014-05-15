%% plot3d.m
%
% plot mesh in 3d
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plot3d(this,varargin)

defaults.faceAlpha = 0.5;
defaults.faceColor = 'white';
param = setDefaultParameters(defaults,varargin);%,'tetraprops');

h = fig(varargin{:});

c = this.getCoordinates();
t = this.getElementTopology('tet');
tetramesh(t,c,...
    'faceColor',param.faceColor,...
    'faceAlpha',param.faceAlpha);

figAdjust(varargin{:});
