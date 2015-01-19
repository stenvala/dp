function setTagsChangeByIndex(this,ind,to,elemType)
  % Tag changer: change tags in indices
  %
  % parameters:
  %   - ind (what indices to put)
  %   - to (new tag)
  %   - elemType  
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %    
  this.msh.(elemType).tags(ind) = to;  
end
