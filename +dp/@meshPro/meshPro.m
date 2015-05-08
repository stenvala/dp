classdef meshPro < dp.mesh
  % Extended mesh class for dp. This is where you add basis functions etc.
  %
  % varargin:
  %   - see parent
  %
  % Created: Your name (your email)
  % Contributed:
  
  properties (GetAccess=protected,SetAccess=protected)
    
  end
  methods (Access=public)
    %% Constructor (cannot be in separate file)
    function this = meshPro(varargin)
      % call parent constructor
      this = this@dp.mesh(varargin{:});
    end        
  end
  methods (Access=protected)
    
  end
  methods (Access=private)
    
  end
end
