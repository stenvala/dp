function setTagsChangeByCoordFunAnyNode(this,to,fun,elemType,from)
  % Tag changer: change element tag when any node fulfills this equation
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
        this.setTagsChange(to,fun,elemType{k},from);
      else
        this.setTagsChange(to,fun,elemType{k});
      end
    end
    return;
  end
  
  nodes= find(feval(fun,this.getCoordinates()));  
  elems = this.msh.(elemType).elems;
  elemsTrue = zeros(size(elems,1),1);
  for k=1:size(elems,2)
    [~, ind] = ismember(elems(:,k),nodes);
    elemsTrue(ind > 0) = 1;
  end
  
  if nargin > 4 && ~isempty(from)    
    elems = [];
    from = unique(from);
    for k=1:length(from)      
      elems = [elems;find(this.msh.([type 'Tags']) == from(k))];
    end
    elems = unique(elems);
    elemsTrue = intersect(elemsTrue,elems);
    numOfChanges = length(elemsTrue);
  else    
    numOfChanges = sum(elemsTrue);
  end
  
  this.msh.(elemType).tags(find(elemsTrue)) = to;
  disp(['Modified ' num2str(numOfChanges) ' tags to ' num2str(to) '.'])
end
