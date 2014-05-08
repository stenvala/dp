%% plot2d.m
%
% plot mesh in 2d
%
% Created: Antti Stenvall (antti@stenvall.fi)

function h = plot2d(this,varargin)

h = fig(varargin{:});

c = this.getCoordinates();
t = this.getElementTopology('tri');
trimesh(t,c(:,1),c(:,2),c(:,3));

figAdjust(varargin{:});
