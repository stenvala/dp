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
  dummyNodes = isnan(nodesInUse);
  this.setUpdateCoordinates(c(~dummyNodes,:));
  % update all nodes to new values according to the removed nodes
  newIndices = (1:size(c,1))';
  toRemove = find(dummyNodes)';
  % faster heuristics: if all the nodes at the end must be removed, there
  % is no need to change the indices, otherwise one needs to change them
  if toRemove(end) == length(newIndices) && ...
    (toRemove(end) - toRemove(1)) == (length(toRemove)-1)
  else
    for k=find(dummyNodes)'
      newIndices(k:end) = newIndices(k:end)-1;      
    end
  end
  newIndices(dummyNodes) = nan;
  
  % update element entities
  for p=1:length(this.reader)
    type = this.reader{p}.name;
    if isfield(this.msh,type)
      this.msh.(type).elems = newIndices(this.msh.(type).elems);
    end
  end
  
end
