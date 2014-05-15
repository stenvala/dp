%% main.m
%
% First laboratory work: Laplace solver in 2D
%
% Created: Antti Stenvall (antti@stenvall.fi)

clear all;
close all;
clc

%% Initialize mesh
% define modelling domain with a .geo file
file = 'modellingDomain';
msh = dpMesh(file);
% You are supposed to inherit dpMesh to dpMeshPro where you add your own
% methods related to e.g. basis functions, they don't belong to solver class
% msh = dpMeshPro(file); 

elementOrder = 1; % your code needs to work with 1 or 2
% make mesh
if ~exist([file '.mat'],'file') || 1
    msh.make('order',1);
    msh.read();
    msh.save();
end
% or load mesh to save time (remember that element order is fixed in mesh
% generation)
msh.load();

%% What lets visualize the mesh
if 1
    msh.plot2D('figure',1); % plot mesh
    msh.plotPhysicalDomains2D('figure',2); % show different domains in mesh
    msh.plotPhysicalDomains1D('figure',3,'lineWidth',2); % plot physical boundaries        
end
%% Here you define the material properties

% domain properties
domain.labels = [2001 2002]; % refer to tags of modelling domain
domain.material = {5.69,3.5}; % this is cell array so that values can be scalar, matrices, function handles etc.
domain.source = {0,0}; % in this we define the source quantities in Poisson problems

% boundary conditions
boundary.labels = [1001 1002 1003];
boundary.type = {'neu','dir','dir'};
boundary.value = {0,1,0};

% construct solver object
prob = dpSolver();
% init Laplace problem
prob.initLaplace(boundary,domain);
% solve with given mesh
prob.solveLaplace(msh);
%% Simple post-processing
coords = msh.getCoordinates();
if elementOrder == 1
   el = msh.getElementTopology('tri');
else
   el = msh.getElementTopology('tri2');
end
trisurf(el(:,1:3),...
    coords(:,1),...
    coords(:,2),...
    prob.getLaplaceSolutionAtNodes(),...
    'edgecolor','none','facecolor','interp');