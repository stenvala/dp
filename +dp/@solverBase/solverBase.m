classdef solverBase < handle
  % Solver base class for dp. 
  %
  % Specialized solver should be inherited from this. If you want to make 
  % some general methods related to solvers, add them here.
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  % Contributed: 
  %
  
  properties (GetAccess=protected,SetAccess=protected)
    problem % this is where you init your problem structure via init method
  end
  methods (Access=public)
    %% Constructor
    function this = solverBase(varargin)
      
    end
    init(this,boundary,domain);
  end  
end
