function constructFullEdgeStructure(this,tag)
  % Add all the edges to the edg structure.
  %
  % Adds new edges but keeps old so that every edge is in the structure
  % after calling this. Works only for triangular elements
  %
  % parameters:
  %  - tag: tag to give to new edges
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  numNodes = this.getNumberOfNodes();
  numEdges = numNodes + this.getNumberOfElements('tri')-1;
  
  existing = this.getElementTopology('edg');
  existingSorted = sort(existing,2);
  
  numNewEdges = numEdges-size(existing,1);
  newEdgesStructure = zeros(numNewEdges,2);
  newEdgeNum = 1;
  top = this.getElementTopology('tri');
  for k=1:numNodes
    [el dummy] = find(top == k);
    otherNodes = top(el,:);
    otherNodes = unique(otherNodes(:));
    otherNodes = sort(otherNodes(otherNodes>k));
    if ~isempty(otherNodes)
      % check if exists in already created structure
      [ex dummy] = find(existingSorted == k);
      for p=1:length(otherNodes)
        if ~isempty(ex)
          if any(any(existingSorted(ex,:) == otherNodes(p)))
            continue;
          end
        end
        newEdgesStructure(newEdgeNum,:) = [k,otherNodes(p)];
        newEdgeNum = newEdgeNum + 1;
        if newEdgeNum > numNewEdges
          break;
        end
      end
    end
    if newEdgeNum > numNewEdges
      break;
    end
  end
  
  numNewEdges = size(newEdgesStructure,1);
    
  %% All the edges must be from the smaller number to the large
  this.msh.edg.elems = [existingSorted; newEdgesStructure];
  this.msh.edg.nums = [this.msh.edg.nums; (1:numNewEdges)' + max(this.msh.edg.nums)];
  this.msh.edg.tags = [this.msh.edg.tags; tag*ones(numNewEdges,1)];
  this.msh.edg.tagsElementary = [this.msh.edg.tagsElementary; tag*ones(numNewEdges,1)];
  
  % Present all the triangles with edges
  edgeRepresentation = zeros(size(top));
  edgeRepresentationOrientation = ones(size(top));
  for k=1:size(top,1)    
    edges = [top(k,1) top(k,2); top(k,2) top(k,3); top(k,3) top(k,1)];
    for p=1:3      
      edge = edges(p,:);
      if edge(1) > edge(2)
        edgeRepresentationOrientation(k,p) = -1;
      end
      edge = sort(edge);
      index = find((this.msh.edg.elems(:,1) == edge(1)) .* ...
        (this.msh.edg.elems(:,2) == edge(2)),1);          
      edgeRepresentation(k,p) = index;            
    end    
  end
  this.msh.tri.edgeRep.elems = edgeRepresentation;
  this.msh.tri.edgeRep.orien = edgeRepresentationOrientation;
  
end