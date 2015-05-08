%% Computer lab: linear isotropic elasticity - plane strain
%
% Do not modify the function calls, but you need to add, for example
% correct boundary conditions.
%
% Created: Antti Stenvall (antti@stenvall.fi)
% Contributed:
%

clear all;
close all;
clc

%% Initialize mesh
% define modelling domain with a .geo file
file = 'modellingDomainSparse'; % this will produce a mesh close to Clough's original mesh
%file = 'modellingDomain';

msh = dp.meshPro('project',file);

elementOrder = 2; % your code needs to work with element order 1 and 2
% make mesh
mfileName = [file '-' num2str(elementOrder) '.mat'];

if ~exist(mfileName,'file') || 1
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
E = 26e9; % Young's modulus
v = 0.15; % Poisson's ratio
density = 2400;
g = 9.81; % gravitational acceleration
material.model = 'lame'; % define the material model
% define the properties for material model
material.lame1parameter = E*v/((1+v)*(1-2*v));
material.shearModulus = 2.2e9;

% domain properties
domain.labels = 2001;
domain.material = {material};
domain.source = {[0; -density*g]};

% boundary conditions
boundary.labels = [1001 1002];
boundary.type = {'dir','neu'};
% the second term is the hydrostatic pressure
boundary.value = {[0;0],@(x,y) g*1000*(0.3048*264-y)};

% construct solver object and solve problem. You need to do this
prob = dp.solvers.planeStrain();
prob.init(boundary,domain);
prob.solve(msh);

%% Simple post-processing
msh.setCoordinatesName('original');
xy = prob.getDisplacementAtNodes();
oldCoords = msh.getCoordinates();
scalex = 1e3; % scale the new solution, because otherwise it is not possible to see the difference
scaley = scalex;
newCoords = oldCoords(:,1:2)+xy*[scalex 0;0 scaley];
msh.setCoordinates(newCoords,'name','deformed');
% display, behind the old coordinates and new in front
msh.setCoordinatesActive('original');
msh.plot2d('figure',1,'edgeColor','blue');
msh.setCoordinatesActive('deformed');
hold on
msh.plot2d('figure',0,'edgeColor','red');