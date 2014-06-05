function s = setElem(this,elemType,ent,tag,num)
  % Set new element types
  %
  % parameters:
  %   - elemType: element type string
  %   - ent: definitions of elements
  %   - tag: element tags
  %   - num: element numbers
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  this.msh.(elemType).elems = ent;
  this.msh.(elemType).tags = tag;
  this.msh.(elemType).nums = num;
end
