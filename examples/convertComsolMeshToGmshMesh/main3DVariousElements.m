%% Example of converting comsol mesh to gmsh mesh and changing element tags
% when several different element types are present
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain3DVariousElements';

msh = dpMesh('project',project,'dim',3);
% read mesh
msh.readComsol();
% remove element entities
msh.setRemoveElementEntities('vtx');
msh.setRemoveElementEntities('edg');
% change some tags
% boundary
allTags = unique(msh.getElementTags('tri'));
msh.setTagsChange(allTags,2001,'tri');
allTags = unique(msh.getElementTags('quad'));
msh.setTagsChange(allTags,2002,'quad');
% volume elements
allTags = unique(msh.getElementTags('tet'));
msh.setTagsChange(allTags,3001,'tet');
allTags = unique(msh.getElementTags('hex'));
msh.setTagsChange(allTags,3002,'hex');
allTags = unique(msh.getElementTags('pyr'));
msh.setTagsChange(allTags,3003,'pyr');
% write to .msh
msh.write();

m = msh.getMesh();


%% Some basic operation with the msh object
msh.plotPhysicalDomains3d('axis','equal',...
  'height',16,'width',16',...
  'view',[-42 36],...  
  'figure',1,'offsetx',1,'title','From Comsol mesh',...
  'faceAlpha',0.5,...
  'faceColor','white','xlabel','$x$','ylabel','$y$','zlabel','$z$',...
  'useLatex',1);
