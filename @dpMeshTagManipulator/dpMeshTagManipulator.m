classdef dpMeshTagManipulator < dpMesh
  % Extended mesh class for dp, manipulates mesh tags
  % this is handy when mesh is generated with Comsol and specific tags are
  % needed.
  %
  % varargin:
  %   - see parent
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  % 
    
  methods (Access=public)
    %% Constructor (cannot be in separate file)
    function this = dpMeshTagManipulator(varargin)
      % call parent constructor
      this = this@dpMesh(varargin{:});
    end
    % remove duplicate nodes coordinates and unused nodes
    setRemoveDuplicateCoordinates(this,tol);    
    setRemoveUnusedNodes(this);
    % remove element entities
    setRemoveElementEntities(this,elemType,tags);
    setRemoveElementByCoordFun(this,to,fun,elemType,from);
    setResetElementNumbering(this);
    % tag changers
    setTagsChange(this,from,to,elemType);    
    setTagsChangeByCoordFun(this,to,fun,elemType,from);
    setTagsChangeByCoordFunAnyNode(this,to,fun,elemType,from);
    setTagsChangeByIndex(this,from,to,elemType);
    setTagsChangeBySubElementTag(this,to,elemType,subType,subTag,from);
    setTagsChangeByNearestCoord(this,to,coord,elemType);   
  end  
end
