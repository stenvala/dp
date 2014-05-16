%% dpMesh.m
%
% mesh module for dp
%
% Created: Antti Stenvall (antti@stenvall.fi)

classdef dpMesh < handle
    properties (GetAccess=protected)
        project % project name, works also for .geo, .msh etc, WITHOUT extension and .
        geoFile % contents of .geo file
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
        function this = dpMesh(project,varargin) % initialize with fileName where to read/load the mesh/data            
            if nargin > 0
               this.project = project;
            end
            defaults.dim = 2;            
            param = setDefaultParameters(defaults,varargin);
            this.dim = param.dim;
            this.initdata.time = clock;
            this.initdata.date = date;            
            this.charts = {};
            this.chartsActive = 0;
            workingDir = dpInit(); % dpInit needs to be in Matlab path
            this.gmshPath = [workingDir 'gmsh\gmsh.exe']; % this works now only in Windows
            % init mesh reader properties
            this.setInitReaderProperties();                   
        end
        %% Initial setters and comparable void functions 
        % (like interface to gmsh mesh generation and reading, load and save object data)
        % mesh related primary functions
        load(this,varargin); % load msh from .mat file
        make(this,varargin); % generate mesh from from .geo file with Gmsh        
        read(this,varargin); % read mesh from .msh file   
        readComsol(this,varargin); % read mesh from Comsol .mphtxt file
        save(this,varargin); % save msh to .mat file
        write(this,varargin); % write msh to .msh file
        % mesh related auxiliary
        addGeoFileContents(this,varargin); % read geo file contents
        %% Getters 
        % Specification for return
        % msh=mesh struct 
        % c=cell array        
        % m=matrix  
        % v=vector (or scalar)
        % s=scalar 
        % st=struct
        % F=interpolant function
        % u=undefined / user should know       
        m = getCoordinates(this);
        m = getCoordinatesAtElementCenter(this,elementEntity);
        v = getElementNumbers(this,elementEntity);
        v = getElementTags(this,elementEntityOrDim);
        m = getElementTopology(this,elementEntity);
        c = getElementsInUse(this,dim);        
        msh = getMesh(this);
        s = getNumberOfElements(this,elementEntities);
        v = getnVolumes(this,elementEntity);
        st = getTime(this);
        %% Setters
        setCoordinates(this,coordinates,varargin); % add coordinate system (nodes' locations)        
        setCoordinatesActive(this,indOrName); % change the active coordinate system
        setCoordinatesName(this,name); % set name for the active coordinate system
        setCoordinatesTranslate(this,fun);
        setnVolumes(this); % compute areas, length, volumes of mesh entities        
        % remove element entities
        setRemoveElementEntities(this,elemEntity,tags);
        % tag changers        
        setTagsChange(this,from,to,elemEntity);
        setTagsChangeByCoordFun(this,to,fun,elemEntity,from);
        setTagsChangeByNearestCoord(this,to,coord,elemEntity);
        %% Displayers
        displayStatistics(this,varargin);
        %% Basic plotters (h=handle)
        % mesh visualization
        %h = plot1D(this,varargin);
        h = plot2D(this,varargin);
        h = plot3D(this,varargin);
        h = plotPhysicalDomains1D(this,varargin);
        h = plotPhysicalDomains2D(this,varargin);
        h = plotPhysicalDomains3D(this,varargin);
    end
    methods (Access=protected)
        %% Getters
        s = getActiveChart(this); % use always this to get chart                
        %% Setters
        setDimensionToView(this);
        setInitElementEntities(this,nmbElems);
        setInitReaderProperties(this);
        setRemoveNaNelems(this);
        setRemoveUnusedElementEntities(this);        
    end
end
