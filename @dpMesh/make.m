%% make.m
%
% generate mesh with gmsh, windows version
%
% Created: Antti Stenvall (antti@stenvall.fi)

function make(this,varargin)

defaults.directory = pwd;
defaults.order = 1;
defaults.fileName = [this.project '.geo'];
param = setDefaultParameters(defaults,varargin);

tic
dos(['"' this.gmshPath '" ' ...
    '"' fullfile(param.directory,param.fileName) '" ' ...
    '-' num2str(this.dim) ' -order ' num2str(param.order) ' -o ' ...
    '"' fullfile(param.directory,param.fileName) '.msh"']);
this.time.makeMesh = toc;

end
