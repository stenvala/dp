%% dpMesh.m
%
% mesh module for dp
%
% Created: Antti Stenvall (antti@stenvall.fi)

classdef dpMesh < handle & toolsObject
    properties (GetAccess=protected)
        project % project name, works also for .geo, .msh etc, WITHOUT extension and .
        geoFiles % contents of .geo files
        msh % all the topological mesh data
        charts % all the coordinate systems (charts) of the modelling domain
        chartsActive % which one is active or default
        initdata % some initial data
        time % execution time related stuff
        dim % dimension of the modelling domain
        gmshPath % path to gmsh (gmsh is used for mesh generation)        
        reader % different reader properties
     end
    methods (Access=public)
        %% Constructor (cannot be in separate file)
        function this = dpMesh(project,dim) % initialize with fileName where to read/load the mesh/data
            if nargin > 0
                this.project = project;
            end
            if nargin < 2
                dim = 2; % default dimension
            end
            this.dim = dim;
            this.initdata.time = clock;
            this.initdata.date = date;            
            this.charts = {};
            this.chartsActive = 0;
            workingDir = dpInit(); % dpInit needs to be in Matlab path
            this.gmshPath = [workingDir 'gmsh\gmsh.exe']; % this works now only in Windows
            % init mesh reader properties
            this.reader.supportedTypes.names = {'vtx','edg','tri','quad','tet','hex','pri','pyr','edg2','tri2','tet2'}; 
            this.reader.supportedTypes.comsol.names = {'vtx','edg','tri','quad','tet','hex','pri','pyr'}; 
            this.reader.supportedTypes.gmsh.types = [15 1 2 3 4 5 6 7 8 9 11]; % these are gmsh types
            this.reader.supportedTypes.vertices = [1 2 3 4 4 8 6 5 3 6 10]; % these are corresponding vertice numbers            
            this.reader.supportedTypes.dimension = [0 1 2 2 3 3 3 3 1 2 3]; % these are dimensions of supported types
        end
        %% Initial setters and comparable void functions 
        % (like interface to gmsh mesh generation and reading, load and save object data)
        % mesh related primary functions
        make(this,varargin); % generate mesh from from .geo file with Gmsh
        read(this,varargin); % read mesh from .msh file        
        %% Getters 
        % Specification for return
        % msh=mesh struct 
        % charts=array of charts 
        % m=matrix  
        % v=vector (or scalar)
        % s=scalar 
        % F=interpolant function
        % u=undefined / user should know       
        m = getCoordinates(this);
        msh = getMesh(this);
        %% Setters
        setCoordinates(this,coordinates,varargin);
        %% Figure plotters (h=handle)        
    end
    methods (Access=private)
        %% Getters
        s = getActiveChart(this) % use always this to get chart           
        s = getSimplexNameByHighestDimension(this) % get the name of the simplex having model dimension          
        %% Setters
        setInitMesh(this,nmbElems);
        setRemoveNaNelems(this);
    end
end