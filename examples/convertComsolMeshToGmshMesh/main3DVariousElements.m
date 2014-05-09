%% main3DVariousElements.m
%
% example of converting comsol mesh to gmsh mesh and changing element tags
% when several different element types are present
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain3DVariousElements';

msh = dpMesh(project,'dim',3);
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
msh.setTagsChange(allTags,2001,'quad');
% volume elements
allTags = unique(msh.getElementTags('tet'));
msh.setTagsChange(allTags,2001,'tet');
allTags = unique(msh.getElementTags('hex'));
msh.setTagsChange(allTags,2002,'hex');
allTags = unique(msh.getElementTags('pyr'));
msh.setTagsChange(allTags,2003,'pyr');
% write to .msh
msh.write();

m = msh.getMesh();
m.quad.elems(1,:)


%% Some basic operation with the msh object