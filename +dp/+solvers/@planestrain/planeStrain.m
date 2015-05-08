classdef planeStrain < dp.solverBase
  % Plane strain solver class
  %
  % Created: Your name (your e-mail address)
  % Contributed by:
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    msh
  end
  
  methods (Access=public)
    %% Constructor
    function this = planeStrain(varargin)
      this = this@dp.solverBase(varargin{:});
    end
    %% Other public methods, don't change this interface
    solve(this,msh);
    % get solution
    m = getDisplacementAtNodes(this);
  end
  
  methods (Access=protected)
    %% Add new methods that you make here
    
    
  end
end
