function setTagsSwap(this,elementTypes)
  % Swap element tags and tagsElementary 
  %
  % Tags refers to physical tags in Gmsh and this change physical and
  % elementary tags. It is useful if you get a mesh that you need to change 
  % where only the elementary tags are set and you need access to tags
  %
  % parameters:
  %  - elementType {all existing}: string or cell array of element types
  %  where to swap tags
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if nargin < 2
    elementTypes = cell(1,length(this.reader));
    for k=1:length(this.reader)
      elementTypes{k} = this.reader{k}.name;
    end
  else
    if ~iscell(elementTypes)
      elementTypes = {elementTypes};
    end
  end
  
  for k=1:length(elementTypes)
    elementType = elementTypes{k};
    if isfield(this.msh,elementType)
      tags = this.msh.(elementType).tags;
      this.msh.(elementType).tags = this.msh.(elementType).tagsElementary;
      this.msh.(elementType).tagsElementary = tags;
    end
  end
    
end