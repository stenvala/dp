classdef poisson < dp.solverBase
  % Poisson solver class
  %
  % Created: Your name (your e-mail address)  
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    msh
  end
  
  methods (Access=public)
    %% Constructor
    function this = poisson(varargin)
      this = this@dp.solverBase(varargin{:});
    end
    %% Other public methods, don't change this interface
    solve(this,msh); % template for this method exists
    % number of dof getters
    s = getDof(this);
    % get solution
    v = getSolutionAtNodes(this)      
    % integrate total energy
    s = getTotalEnergy(this);
  end
  methods (Access=protected)
    %% Add new methods that you make here
    
    
  end
end
