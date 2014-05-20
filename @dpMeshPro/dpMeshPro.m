classdef dpMeshPro < dpMesh
  % Extended mesh class for dp, includes for example basis functions.
  %
  % varargin:
  %   - see parent
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  % Contributed:
  
  properties (GetAccess=protected,SetAccess=protected)
    
  end
  methods (Access=public)
    %% Constructor (cannot be in separate file)
    function this = dpMeshPro(varargin)
      % call parent constructor
      this = this@dpMesh(varargin{:});
    end
    
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
end
