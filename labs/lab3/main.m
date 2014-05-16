%% main.m
%
% Laboratory work: linear isotropic elasticity - plane strain 
%
% Created: Antti Stenvall (antti@stenvall.fi)

clear all;
close all;
clc

%% Initialize mesh
% define modelling domain with a .geo file
file = 'modellingDomainSparse'; % this will produce a mesh close to Clough's original mesh
%file = 'modellingDomain';

msh = dpMesh(file);
% Because you already have dpMeshPro from lab1, you can uncomment next line
% and remove the previous
% msh = dpMeshPro(file); 

elementOrder = 1; % your code needs to work with element order 1 and 2
% make mesh
mfileName = [file '-' num2str(elementOrder) '.mat'];

if ~exist(mfileName,'file') && 1
    msh.make('order',elementOrder);
    msh.read();
    msh.save('fileName',mfileName);
end
% or load mesh to save time (remember that element order is fixed in mesh
% generation)
msh.load('fileName',mfileName);
%% What lets visualize the mesh
if 1
    msh.plot2D('figure',1); % plot mesh
    msh.plotPhysicalDomains2D('figure',2); % show different domains in mesh
    msh.plotPhysicalDomains1D('figure',3,'lineWidth',2); % plot physical boundaries        
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
domain.labels = [2001]; 
domain.material = {material};    
domain.source = {[0; -density*g]};

% boundary conditions
boundary.labels = [1001 1002];
boundary.type = {'dir','neu'};
% the second term is the hydrostatic pressure
boundary.value = {[0;0],@(x,y) g*1000*(0.3048*264-y)};

% construct solver object and solve problem. You need to do this
prob = dpSolver();
prob.initPlaneStrain(boundary,domain);
prob.solvePlaneStrain(msh);

%% Simple post-processing
msh.setCoordinatesName('original');
strain = prob.getSolutionPlaneStrain(); % strain in each coordinate 
oldCoords = msh.getCoordinates();
scalex = 1e3; % scale the new solution, because otherwise it is not possible to see the difference
scaley = scalex;
newCoords = oldCoords(:,1:2)+strain*[scalex 0;0 scaley];
msh.setCoordinates(newCoords,'name','deformed');
% display, below the old coordinates
msh.setCoordinatesActive('original');
msh.plot2D('figure',1,'edgeColor','blue');
msh.setCoordinatesActive('deformed');
hold on
msh.plot2D('figure',0,'edgeColor','red');