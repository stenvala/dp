function [X W] = getGaussNodesStandardTetrahedron(degree)
  % Get Gauss nodes and weights for a standard tetrahedron in barycentric
  % coordinates
  %
  % output:
  %   - X includes the barycentric coordinates
  %   - W includes the weights
  %
  % parameters:
  %   - degree (polynomials of this degree will be integrated exactly)
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  degree = max(degree,1);
    
  N = ceil((degree+1)/2);
  
  vert = [0 0 0;
    1 0 0;
    0 1 0;
    0 0 1];
  
  % this is FileFxchange function
  [X,Y,Z,W] = tetraquad(N,vert);
  X = [X Y Z];
  
  end