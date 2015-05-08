%% Example of converting comsol mesh to gmsh mesh and changing element tags
% when several different element types are present
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain3DVariousElementsDense';

msh = dp.meshManipulator('project',project,'dim',3);
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
  'edgeColor','w',...
  'height',8,'width',12',...
  'view',[-42 36],...  
  'figure',1,'offsetx',1,'title','Several element types composed',...
  'faceAlpha',.2,...
  'faceColor','white','xlabel','$x$','ylabel','$y$','zlabel','$z$',...
  'useLatex',1);
