function setRemoveElementByCoordFun(this,fun,elemType,from)
  % Tag remover: remove elements when the center coordinate fulfils condition
  %
  % parameters:  
  %   - fun (takes in matrix n*3 of element center coordinates)
  %   - elemType
  %   - from {all elements}: you can only set to change from some
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  
  if iscell(elemType)
    for k=1:length(elemType)
      if nargin > 4
        this.setRemoveElementByCoordFun(fun,elemType{k},from);
      else
        this.setRemoveElementByCoordFun(fun,elemType{k});
      end
    end
    return;
  end
  
  values = feval(fun,getCoordinatesAtElementCenter(this,elemType));
  
  if nargin > 4 && ~isempty(from)
    elemsTrue = find(values);
    elems = [];
    from = unique(from);
    for k=1:length(from)        
      elems = [elems;find(this.msh.(elemType).tags == from(k))];
    end
    elems = unique(elems);
    elemsTrue = intersect(elemsTrue,elems);
    numOfChanges = length(elemsTrue);
  else
    elemsTrue = values;
    numOfChanges = sum(elemsTrue);
  end
  
  this.msh.(elemType).tags(elemsTrue) = nan;      
  this.setRemoveNaNelements();  
  
  disp(['Removed ' num2str(numOfChanges) ' elements.'])
end
