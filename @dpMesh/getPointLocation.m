function [v m] = getPointLocation(this,elemType,coords)
  % Get element and barycentric coordinates of points
  %
  % Finds elements where coordinates belong to. Returns also barycentric
  % coordinates. Works for simplicial elements
  %
  % return values:
  %  - v: vector of size(coords,1) x 1 telling the elements
  %  - m: matrix of size(coords,1) x barycenters (i.e. dim + 1)
  %
  % parameters:
  %  - elemType: element type
  %  - coords: coordinates for which elements are searched
  %  
  % Created: Antti Stenvall (antti@stenvall.fi)  
  %
  
  if this.dim ~= 2
    error('This is implemented only for dimension 2.');
  end
   
  c = this.getCoordinates();
  elementTopology = this.getMesh().(elemType).elems;
  % For this one needs to form element TriRep class for triangles 
  trep = TriRep(elementTopology(:,1:3),c(:,1),c(:,2));
    
  X = coords(:,1);
  Y = coords(:,2);
  
  v = zeros(size(X));
  baryXi = v;
  baryEta = v;
  for k=1:size(X,1)
    for p=1:size(X,2)
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
