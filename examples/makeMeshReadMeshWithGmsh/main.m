%% main.m
%
% example of making mesh from geo file and reading it
%
% Created: Antti Stenvall (antti@stenvall.fi)
clear all;
close all;
clc

%% Initialize mesh
project = 'modellingDomain';

msh = dpMesh(project);
% generate mesh
msh.make();
% read mesh
msh.read();
% get Mesh
m = msh.getMesh();
% get coordinates
c = msh.getCoordinates();