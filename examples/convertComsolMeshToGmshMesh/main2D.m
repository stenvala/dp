%% main2D.m
%
% example of converting comsol mesh to gmsh
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain2D';

msh = dpMesh(project);
% read mesh
msh.readComsol();
% write to .msh
msh.write();
%% display the mesh that was read
msh.plotPhysicalDomains2D('view',[0 90],'axis','equal',...
    'figure',1,'offsetx',1,'title','From Comsol mesh');

msh2 = dpMesh(project);
msh2.read();

% change element tag numbers (just for fun)
allTags = unique(msh2.getElementTags('tri'));
msh2.setTagsChange(allTags(3),allTags(2),'tri');

% plot also the new mesh
msh2.plotPhysicalDomains2D('view',[0 90],'axis','equal',...
    'figure',2,'offsetx',10,'title','From gmsh mesh (tags changed)');

% plot only new tags
msh2.plotPhysicalDomains2D('tags',allTags(2),...
    'view',[0 90],'axis','equal',...
    'figure',3,'offsetx',19,'title',['Region ' num2str(allTags(2)) ' only']);

