classdef dpMesh < handle
  % Mesh module for discrete problem solvers.
  %
  % Flexible platform for constructing solvers that require underlying
  % mesh for reason or another, like finite element method. This can be
  % used in educational purposes. Then, students can use this class for
  % generating meshes and dealing with them. Class can be extended to
  % cover basis functions related operations etc (students SHOULD do
  % this in computer labs).
  %
  % varargin:
  %   - description {''}: description
  %   - dim {2}: dimension of the project, i.e. which are the highest order
  %     elements to mesh
  %   - project {''}: name of the project
  %   - title {''}: title
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    project % project name, works also for .geo, .msh etc, WITHOUT extension and .
    geoFile % contents of .geo file
    msh % all the topological mesh data
    charts % all the coordinate systems (charts) of the modelling domain
    chartsActive % which one is active or default
    initdata % some initial data related to the project
    time % execution time related stuff
    dim % dimension of the modelling domain
    gmshPath % path to gmsh (gmsh is used for mesh generation)
    reader % different reader properties
  end
  methods (Static)
    [X W] = getGaussNodesStandardLine(polynomialDegree);
    [X W] = getGaussNodesStandardTriangle(polynomialDegree);
  end  
  methods (Access=public)
    %% Constructor
    function this = dpMesh(varargin)
      this = this.constructor(varargin{:});      
    end
    %% mesh <-> living object interface
    load(this,varargin);
    make(this,varargin);
    read(this,varargin);
    readComsol(this,varargin);
    save(this,varargin);
    write(this,varargin);
    addGeoFileContents(this,varargin);
    %% Getters
    % Specification for return
    % c=cell array
    % m=matrix
    % v=vector (or scalar)
    % s=scalar
    % st=struct
    % F=interpolant function
    % u=undefined / user should know
    m = getBoundaryOfElementGroup(this,elemType,tag);
    m = getConvexHull(this,elemType,tag);
    s = getDim(this);
    m = getCoordinates(this);
    m = getCoordinatesAtElementCenter(this,elemType);
    m = getCoordinatesAtBarycentricCoordinates(this,elemType,varargin)
    [m, v] = getElementsByTag(this,elemType,tag);
    v = getElementNumbers(this,elemType);
    v = getElementTags(this,elemType);
    m = getElementTopology(this,elemType);
    c = getElementsInUse(this,dim);    
    st = getInitData(this);
    st = getMesh(this);
    s = getNumberOfElements(this,elemType);
    [v m] = getPointLocation(this,elemType,coords);
    v = getnVolumes(this,elemType);
    st = getTime(this);
    v = getTags(this,elemType);    
    %% Setters
    % some advanced method for setting new coordinates
    s = setCoordinates(this,coordinates,varargin);
    setCoordinatesActive(this,indOrName);
    s = setCoordinatesName(this,name);
    setCoordinatesTranslate(this,fun);    
    setElem(this,elemType,ent,tag,num);
    setInitData(this,varargin);
    % this can be utilized to compute volumes of elements
    setnVolumes(this);        
    %% Displayers
    displaySupportedElements(this,varargin);
    displayStatistics(this,varargin);
    %% Basic plotters
    % (h=handle)
    % mesh visualization
    % - see varargin for plot customization: help fig, help figAdjust
    % h = plot1d(this,varargin);
    h = plot2d(this,varargin);
    h = plot3d(this,varargin);
    plotAddLabels(this,varargin);
    h = plotPhysicalDomains1d(this,varargin);
    h = plotPhysicalDomains2d(this,varargin);
    h = plotPhysicalDomains3d(this,varargin);    
  end
  methods (Static)
    writeParamFile(fileName,param);
  end
  methods (Access=protected)
    %% Getters
    s = getActiveChart(this); % use always this to get chart
    st = getElementData(this,elemType); % loads data from this.reader
    %% Setters
    setDimensionToView(this);
    setInitElementEntities(this,nmbElems);
    setInitReaderProperties(this);
    setRemoveNaNelements(this);
    setRemoveUnusedElementEntities(this);
    setUpdateCoordinates(this,coordinates);
  end
  methods (Access=private)
    %% Phantom-constructor defined here
    this = constructor(this,varargin)
  end
end
