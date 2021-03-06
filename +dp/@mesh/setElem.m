function s = setElem(this,elemType,ent,tag,num)
  % Set new element types
  %
  % parameters:
  %   - elemType: element type string
  %   - ent: definitions of elements
  %   - tag: element tags
  %   - num {(1:size(tag,1))'}: element numbers
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  this.msh.(elemType).elems = ent;
  this.msh.(elemType).tags = tag;
  if nargin < 5
    this.msh.(elemType).nums = (1:size(tag,1))';
  else
    this.msh.(elemType).nums = num;
  end
end
