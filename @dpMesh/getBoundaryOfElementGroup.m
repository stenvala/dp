function m = getBoundaryOfElementGroup(this,elemType,tag)
  % Returns the boundary of element group (works currently only for 2-D
  % domains)
  %
  % parameters:
  %   - elemType: type of element for which the boundary is searched
  %   - tag: element group tag
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  % element data
  elemData = this.getElementData(elemType);
  
  bndElem = elemData.bnd;
  bndData = this.getElementData(bndElem);
  bndNodes = bndData.vertices;
  
  tags = this.msh.(elemType).tags;
  elem = this.msh.(elemType).elems(tags == tag,:);
  
  c = this.getCoordinates();
  if strcmp(elemType,'tri')
    TR = triangulation(elem,c(:,1),c(:,2));
    m = freeBoundary(TR);    
  elseif strcmp(elemType,'quad')
    % this algorithm shouldn't be terribly difficult
  else
    error(['Method not implemented for element type ' elemType]);
  end
  
end
