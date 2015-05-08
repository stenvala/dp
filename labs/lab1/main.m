%% Computer lab: Laplace solver in 2-D
%
% Do not modify this file, in your return it must be exactly like now with
% few exceptions, you may change 
%   - CharScale parameter on line 26
%   - Change 1 to 0 in conditions of if on lines 32 and 42
% For the convergence analysis, ake new file mainLoop.m
%
% Created: Antti Stenvall (antti@stenvall.fi)
% Contributed:
%

clear all;
close all;
clc

%% Initialize mesh
% define modelling domain with a .geo file
file = 'modellingDomain';
% dp.meshPro is the mesh object that you can change
msh = dp.meshPro('project',file);

elementOrder = 1; % your code needs to work with 1 and 2 (why not make it independent of this?)

% mesh parameters 
param = struct('CharScale', 3);
dp.mesh.writeParamFile('modellingDomainParameters.geo', param);

% determine mesh file name
mfileName = [file '-' num2str(elementOrder) '.mat'];

if ~exist(mfileName,'file') || 1
  msh.make('order',elementOrder);
  msh.read();
  msh.save('fileName',mfileName);
end
% or load mesh to save time (remember that element order is fixed in mesh
% generation)
msh.load('fileName',mfileName);

%% Visualizes the mesh
if 1
  msh.plot2d('figure',1); % plot mesh    
  msh.plotPhysicalDomains2d('figure',2); % show different domains in mesh
  msh.plotPhysicalDomains1d('figure',3,'lineWidth',2); % plot physical boundaries
  % and display statistics
  msh.displayStatistics();
end
%% Here you define the material properties

% domain properties
domain.labels = [2001 2002]; % refers to tags of modelling domain
domain.material = {5.69,3.5}; % this is cell array so that values can be scalar, matrices, function handles etc.
domain.source = {0,0}; % in this we define the source quantities in Poisson problems

% boundary conditions
boundary.labels = [1001 1002 1003];
boundary.type = {'neu','dir','dir'};
boundary.value = {0,1,0};

% construct solver object
prob = dp.solvers.poisson();
% init Laplace problem
prob.init(boundary,domain);
% solve with given mesh
prob.solve(msh);

%% Simple post-processing. This is almost enough for your return (missing the convergence plots)
coords = msh.getCoordinates();
elementType = msh.getSimplexElementType();
el = msh.getElementTopology(elementType);
trisurf(el(:,1:3),...
  coords(:,1),...
  coords(:,2),...
  prob.getSolutionAtNodes(),... % note, you need to add this method too
  'edgecolor','none','facecolor','interp');

% compute loss with different meshes and make convergence plots as a
% function of nodes for both element orders
loss = 2*prob.getTotalEnergy()*1e-8
