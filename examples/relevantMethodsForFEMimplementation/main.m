%% This example explains the methods of dpMesh student needs for the
% implementation of the FEM solver
%
% Word of warning: when you see here msh.getCoordinates() you don't really
% use this in you @dpMeshPro but you call it there this.getCoordinates().
% Don't get confused with the msh property in dpMesh and msh here. They
% don't have anything in common. However, in your dpSolver
%
% Created: Antti Stenvall (antti@stenvall.fi)

clear all;
close all;
clc

%% Initialize mesh

% Define here the "namespace" of project.
% This namespace hosts (if applicable) following files
%   - .geo
%   - .msh
%   - .mat
%   - .mphtxt
project = 'modellingDomain';
% this constructs the project
% dim defines the maximum dimension
msh = dpMesh('project',project,'dim',2);
% lets give title to our project so we later remember what this is about
msh.setInitData('title','Guide for FEM related methods');
% generate mesh (this assumes that {project}.geo exists) gmsh is used
% order defines the element order
msh.make('order',1);
% read mesh (this reads the mesh from {project}.msh)
msh.read();

%% Some basic operation with the msh object
% In principle, this is all you need from dpMesh in this phase

% get coordinates for each node, nodes are the same as rows in this matrix
% from 1 to size(c,1)
c = msh.getCoordinates();

% get all the element types that are initialized
d1 = msh.getElementsInUse(1); % in 1-D returns edges
d2 = msh.getElementsInUse(2); % in 2-D returns face elements
d3 = msh.getElementsInUse(3); % in 3-D returns volume elements

% in stiffness and mass matrix construction it is useful to go through all the elements
% of the maximum dimension and construct the matrices as needed
% the element type for triangle is 'tri'
% the element type for 2nd order triangle is 'tri2'
% see all the types here
msh.displaySupportedElements();
% this loops through all the 2-dimensional elements
for k=1:length(d2)
  topol = msh.getElementTopology(d2{k}); % this returns the elements
  tags = msh.getElementTags(d2{k}); % and this their tags (for giving e.g. correct material parameters)
end

% to see all the tags you can look at the mesh, see the command window for
% the definition of the colors i.e. their tags
msh.plotPhysicalDomains2d('figure',1,...
  'xlabel','x','ylabel','y');
hold on
msh.plotPhysicalDomains1d('figure',0,'lineWidth',5);
hold off

% note the following will throw exceptions if the element entity doesn't
% exist, of course you can use that property too
t = msh.getElementTopology('tri');
