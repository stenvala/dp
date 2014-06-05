function setRemoveUnusedNodes(this)
  % Remove nodes that do not belong to any elementary entity
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
    % first solve which nodes are in use
  nodesInUse = NaN*zeros(size(this.getCoordinates(),1),1);
  
  % update element entities  
  for p=1:length(this.reader)
    type = this.reader{p}.name;    
    if isfield(this.msh,type)  
      el = this.msh.(type).elems;
      nodesInUse(el(:)) = 1;
    end
    if ~any(isnan(nodesInUse))
      break;
    end
  end  
  c = this.getCoordinates();  
  this.setUpdateCoordinates(c(~isnan(nodesInUse),:));
  % update all nodes to new values according to the removed nodes
  newIndices = (1:size(c,1))';
  size(nodesInUse)
  for k=find(isnan(nodesInUse))'    
    newIndices(k:end) = newIndices(k:end)-1;    
  end
  newIndices(isnan(nodesInUse)) = nan;
  
  % update element entities  
  for p=1:length(this.reader)
    type = this.reader{p}.name;
    if isfield(this.msh,type)      
      this.msh.(type).elems = newIndices(this.msh.(type).elems);     
    end
  end
  
end
