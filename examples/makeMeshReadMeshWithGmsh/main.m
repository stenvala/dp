%% Example of making mesh from geo file and reading it
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain';

msh = dpMesh('project',project);
% generate mesh
msh.make();
% read mesh
msh.read();

%% Some basic operation with the msh object

% get Mesh
m = msh.getMesh();
% get coordinates
c = msh.getCoordinates();
% set n-volumes
msh.setnVolumes();
% get triangle areas
msh.getnVolumes('tri');
% plot mesh
msh.plot2d('view',[0 90],'caxis',[0 1]);
saveas(gcf,'figMesh.png') % for publications: saveas(gcf,'figMesh.eps','psc2')
% plot different domains of mesh
msh.plotPhysicalDomains2d('view',[0 90],...
    'tags',[2001 2002],...
    'colors',{'r',[0 0.5 0]});
saveas(gcf,'figMeshDomains.png')