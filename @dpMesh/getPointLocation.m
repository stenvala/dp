function [v m] = getPointLocation(this,elemType,coords)
  % Get element and barycentric coordinates of points
  %
  % Finds elements where coordinates belong to. Returns also barycentric
  % coordinates. Works for simplicial elements. If given coordinate is not
  % in any element, v will have entry nan in corresponding index. This 
  % works at least in Matlab  R2011b, in the newest Matlab, one could 
  % implement this in a different way. This does not scale well for large 
  % coords. In that case one should use different method.
  %
  % return values:
  %  - v: vector of size(coords,1) x 1, including the elements where the
  %       given points locate
  %  - m: matrix of size(coords,1) x barycenters (i.e. dim + 1)
  %
  % parameters:
  %  - elemType: element type (string)
  %  - coords: coordinates for which elements are searched (2/3 x n matrix)
  %  
  % Created: Antti Stenvall (antti@stenvall.fi)  
  %
  
  if this.dim ~= 2
    error('This is implemented only for dimension 2.');
  end
   
  c = this.getCoordinates();
  elementTopology = this.getMesh().(elemType).elems;
  % One needs instance TriRep class for triangles   
  trep = TriRep(elementTopology(:,1:3),c(:,1),c(:,2));
    
  X = coords(:,1);
  Y = coords(:,2);
  
  v = zeros(size(X));
  baryXi = v;
  baryEta = v;
  for k=1:size(X,1)
    for p=1:size(X,2)
      % convert cartesian coordinates to barycentric and find the element
      % where all barcentric coordinates are between 0 and 1
      barys = trep.cartToBary((1:size(trep,1))', repmat([X(k,p) Y(k,p)],size(trep,1),1));      
      el = find(all((0<=barys)&(barys<=1),2));      
      if isempty(el)
        el = NaN;
      else
        b = barys(el(1),:);
        baryXi(k,p) = b(1);
        baryEta(k,p) = b(2);
      end
      v(k,p) = el(1);
    end
  end
  
  m = [baryXi baryEta 1-baryXi-baryEta];

end
