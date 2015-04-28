%% Computer lab: Poisson solver in 2-D
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
msh = dpMeshPro('project',file);

elementOrder = 1; % your code needs to work with 1 and 2
% make mesh
mfileName = [file '-' num2str(elementOrder) '.mat'];

if ~exist(mfileName,'file') || 0
  msh.make('order',elementOrder);
  msh.read();
  msh.save('fileName',mfileName);
end

% or load mesh to save time (remember that element order is fixed in mesh
% generation)
msh.load('fileName',mfileName);


%% What lets visualize the mesh
if 0
  msh.plot2d('figure',1); % plot mesh
  msh.plotPhysicalDomains2d('figure',2); % show different domains in mesh
  msh.plotPhysicalDomains1d('figure',3,'lineWidth',2); % plot physical boundaries
  % and display statistics
  msh.displayStatistics();
end

%% Set up problem
mu0 = pi*4e-7;
mur = 100;
% domain properties
domain.labels = [2001 2002 2003];
domain.material = {1,1/mur,1}; % multiply equation by mu0
domain.nu = {1/mu0,1/mu0/mur,1/mu0}; % use this in energy integration in post processing
currentDensity = 1;
domain.source = {currentDensity*mu0,0,0};

% boundary conditions
boundary.labels = [1001 1002 1003 1004];
% find out boundary conditions yourself, remember only homogeneous Neumann
% and Dirichlet conditions
boundary.type = {};
boundary.value = {};

% construct solver object
prob = dpSolver();
% init Laplace problem
prob.initLaplace(boundary,domain);
% solve with given mesh
prob.solveLaplace(msh); % extend youd Laplace solver also for Poisson problems

%% Now, call the post processing script
pp;