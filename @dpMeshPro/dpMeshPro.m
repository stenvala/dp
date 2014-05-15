%% dpMeshPro.m
%
% extended mesh module for dp, includes for example basis functions
%
% Created: Antti Stenvall (antti@stenvall.fi)
% Contributed: 

classdef dpMeshPro < dpMesh
    properties (GetAccess=protected)
        
    end
    methods (Access=public)
        %% Constructor (cannot be in separate file)
        function this = dpMeshPro(varargin) 
            % call parent constructor
            this = this@dpMesh(varargin{:});            
        end
        
    end
    methods (Access=private)
        
    end
end
