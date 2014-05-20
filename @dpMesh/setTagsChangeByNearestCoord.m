function setTagsChangeByNearestCoord(this,to,coord,elemType)
  % Tag changer: determine tag change by searching the tag of the nearest coordinate.
  %
  % Uses Cartesian metric.
  %
  % parameters:
  %   - to
  %   - coord: 3*1 vector of the coordinates
  %   - elemType
  %   - from {all elements}: you can only set to change from some
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if iscell(elemType)
    for k=1:length(elemType)
      this.setTagsChangeByNearestCoord(to,coord,elemType{k});
    end
    return;
  end
  
  c = this.getCoordinatesAtElementCenter(elemType);
  
  dist = (c(:,1)-coord(1)).^2+(c(:,2)-coord(2)).^2+(c(:,3)-coord(3)).^2;
  
  minInd = find(dist == min(dist),1);
  
  from = this.msh.(elemType).tags(minInd);
  
  this.setTagsChange(from,to,elemType);
  
end