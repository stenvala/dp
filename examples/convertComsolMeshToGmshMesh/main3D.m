%% Example of converting 3D comsol mesh to gmsh mesh and changing element tags
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain3D';

msh = dpMesh('project',project,'dim',3);
% read mesh
msh.readComsol();
% change some tags on the boundary
allTags = unique(msh.getElementTags('tri'));
topFun = @ (xyz) xyz(:,3) > (.2-1e-6);
bottomFun = @ (xyz) xyz(:,3) < 1e-6;
msh.setTagsChangeByCoordFun(2000,topFun,'tri');
msh.setTagsChangeByCoordFun(2001,bottomFun,'tri');
msh.setTagsChange(allTags,2002,'tri');
msh.setTagsChangeByNearestCoord(3001,[-0.4 0.5 0],'tet');
msh.setTagsChangeByNearestCoord(3001,[0.4 0.5 0],'tet');
msh.setTagsChangeByNearestCoord(3002,[0 -0.4 0],'tet');
msh.setTagsChangeByNearestCoord(3003,[0 1.4 0],'tet');
% remove element entities
msh.setRemoveElementEntities('vtx');
msh.setRemoveElementEntities('edg');
% write to .msh
msh.write();

%% Visualize mesh (from boundary)
msh.plotPhysicalDomains2d('axis','equal',...
    'view',[-42 36],...
    'figure',1,'offsetx',1,'title','From Comsol mesh',...
    'faceColor','white','xlabel','$x$','ylabel','$y$','zlabel','$z$',...
    'useLatex',1);
