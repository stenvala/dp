classdef meshManipulator < dp.mesh
  % Extended mesh class for dp, manipulates mesh 
  % this is handy when mesh is generated with Comsol and specific tags are
  % needed, or something is oriented in a wrong way
  %
  % varargin:
  %   - see parent
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  % 
    
  methods (Access=public)
    %% Constructor (cannot be in separate file)
    function this = meshManipulator(varargin)
      % call parent constructor
      this = this@dp.mesh(varargin{:});
    end    
    % fix outer edge orientation
    setFixBoundaryOrientation3D(this,varargin);  
    setFixOrientation3D(this,varargin);
    % remove duplicate nodes coordinates and unused nodes
    setRemoveDuplicateCoordinates(this,tol);    
    setRemoveUnusedNodes(this);
    % remove element entities
    setRemoveElementEntities(this,elemType,tags);
    setRemoveElementByCoordFun(this,fun,elemType,from);
    setResetElementNumbering(this);    
    % tag changers    
    setTagsChange(this,from,to,elemType);    
    setTagsChangeByCoordFun(this,to,fun,elemType,from);
    setTagsChangeByCoordFunAnyNode(this,to,fun,elemType,from);
    setTagsChangeByIndex(this,from,to,elemType);
    setTagsChangeBySubElementTag(this,to,elemType,subType,subTag,from);
    setTagsChangeByNearestCoord(this,to,coord,elemType);   
    setTagsSwap(this,elementTypes);
  end  
end
