function m = getCoordinatesAtBarycentricCoordinates(this,elemType,varargin)
  % Get coordinates at barycentric coordinates
  %
  % parameters:
  %   - elemType: element short name
  %
  % varargin:
  %   - barycentric coordinates separated by comma, as many as them are
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %    
  
  c = this.getCoordinates();
  e = this.msh.(elemType).elems;
  elems = size(e,1);
  nodes = size(e,2);
  m = zeros(elems,3);
  for k=1:length(varargin)
    m = m + [varargin{k}*c(e(:,k),1) ...
      varargin{k}*c(e(:,k),2)...
      varargin{k}*c(e(:,k),3)];
  end 
end
