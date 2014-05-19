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
msh = dpMesh('project',file);
% Because you already have dpMeshPro from lab1, you can uncomment next line
% and remove the previous
% msh = dpMeshPro(file); 

elementOrder = 1; % your code needs to work with 1 and 2
% make mesh
mfileName = [file '-' num2str(elementOrder) '.mat'];

if ~exist(mfileName,'file')
    msh.make('order',elementOrder);
    msh.read();
    msh.save('fileName',mfileName);
end
% or load mesh to save time (remember that element order is fixed in mesh
% generation)
msh.load('fileName',mfileName);


%% What lets visualize the mesh
if 1
    msh.plot2d('figure',1); % plot mesh
    msh.plotPhysicalDomains2d('figure',2); % show different domains in mesh
    msh.plotPhysicalDomains1d('figure',3,'lineWidth',2); % plot physical boundaries        
    % and display statistics
    msh.displayStatistics();
end

%% Set up problem

% domain properties
domain.labels = [2001 2002 2003];
domain.material = {1,1/100,1}; % divide equation by 1e7 to get nice numbers
domain.source = {1,0,0};

% boundary conditions
boundary.labels = [1001 1002 1003 1004];
% find out boundary conditions yourself
boundary.type = {};
boundary.value = {};

% construct solver object
prob = dpSolver();
% init Laplace problem
prob.initLaplace(boundary,domain);
% solve with given mesh
prob.solveLaplace(msh); % extend youd Laplace solver also for Poisson problems

%% Simple post-processing. This is not enough for your return
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