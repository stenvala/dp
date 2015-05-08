function setTagsChangeByCoordFunAnyNode(this,to,fun,elemType,from)
  % Tag changer: change element tag when any node in the domain fulfills
  % the condition
  %
  % parameters:
  %   - to
  %   - fun (takes in matrix n*3 of element center coordinates)
  %   - elemType
  %   - from {all elements}: you can only set to change from some
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  
  if iscell(elemType)
    for k=1:length(elemType)
      if nargin > 4
        this.setTagsChangeByCoordFunAnyNode(to,fun,elemType{k},from);
      else
        this.setTagsChangeByCoordFunAnyNode(to,fun,elemType{k});
      end
    end
    return;
  end
  
  nodes = find(feval(fun,this.getCoordinates()));  
  elems = this.msh.(elemType).elems;
  elemsTrue = zeros(size(elems,1),1);
  for k=1:size(elems,2)
    [~, ind] = ismember(elems(:,k),nodes);
    elemsTrue(ind > 0) = 1;
  end  
  tags = unique(this.msh.(elemType).tags(elemsTrue == 1));
  
  if nargin > 4 && ~isempty(from)    
    tags = intersect(from,tags);
  end
  for k=1:length(tags)
    this.msh.(elemType).tags(this.msh.(elemType).tags == tags(k)) = to;
  end
  %disp(['Modified ' num2str(numOfChanges) ' tags to ' num2str(to) '.'])
end
